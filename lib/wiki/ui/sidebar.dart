import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wiki_project/constants.dart';

class Sidebar extends StatelessWidget {
  final Map<String, List<Map<String, String>>> routes;

  const Sidebar({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      backgroundColor: Colors.grey[200],
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(title: const Text('Início'), onTap: () => context.go('/')),
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
                    onExpansionChanged: (value) => context.go('/${entry.key}'),
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
    );
  }
}
