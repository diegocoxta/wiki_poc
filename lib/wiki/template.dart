import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_project/docs_index.g.dart';

final backgroundColor = Colors.white;

class Template extends StatelessWidget {
  final Widget child;
  const Template({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final routes = <String, List<Map<String, String>>>{};

    for (var doc in docsIndex.where((d) {
      final file = d['file']!.toLowerCase();
      return !(file.endsWith('/index.md') || file == 'index.md');
    })) {
      final parts = doc['slug']!.split('/');
      final category = parts.length > 1 ? parts.first : '';
      routes.putIfAbsent(category, () => []).add(doc);
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 250,
              child: Drawer(
                backgroundColor: Colors.grey[200],
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    // Link para Home
                    ListTile(
                      title: const Text('Início'),
                      onTap: () => context.go('/'),
                    ),

                    // Categorias e docs
                    for (var entry in routes.entries)
                      entry.key.isEmpty
                          ? Column(
                              children: [
                                for (var doc in entry.value)
                                  ListTile(
                                    title: Text(doc['title']!),
                                    onTap: () => context.go('/${doc['slug']}'),
                                  ),
                              ],
                            )
                          : ExpansionTile(
                              title: Text(entry.key),
                              onExpansionChanged: (value) => context.go(
                                '/${entry.key}',
                              ), // Navega para a categoria
                              children: [
                                for (var doc in entry.value)
                                  ListTile(
                                    title: Text(doc['title']!),
                                    onTap: () => context.go('/${doc['slug']}'),
                                  ),
                              ],
                            ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(padding: const EdgeInsets.all(16), child: child),
            ),
          ],
        ),
      ),
    );
  }
}
