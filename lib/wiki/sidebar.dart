import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../docs_index.g.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Agrupa por categoria
    final grouped = <String, List<Map<String, String>>>{};

    for (var doc in docsIndex.where((d) {
      final file = d['file']!.toLowerCase();
      return !(file.endsWith('/index.md') || file == 'index.md');
    })) {
      final parts = doc['slug']!.split('/');
      final category = parts.length > 1 ? parts.first : '';
      grouped.putIfAbsent(category, () => []).add(doc);
    }

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Link para Home
          ListTile(title: const Text('Início'), onTap: () => context.go('/')),

          // Categorias e docs
          for (var entry in grouped.entries)
            entry.key.isEmpty
                ? Column(
                    children: [
                      for (var doc in entry.value)
                        ListTile(
                          title: Text(doc['title']!),
                          onTap: () => context.go('/docs/${doc['slug']}'),
                        ),
                    ],
                  )
                : ExpansionTile(
                    title: Text(entry.key),
                    children: [
                      for (var doc in entry.value)
                        ListTile(
                          title: Text(doc['title']!),
                          onTap: () => context.go('/docs/${doc['slug']}'),
                        ),
                    ],
                  ),
        ],
      ),
    );
  }
}
