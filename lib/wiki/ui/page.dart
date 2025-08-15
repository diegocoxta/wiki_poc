import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:wiki_project/docs_index.g.dart';
import 'package:wiki_project/wiki/ui/sidebar.dart';
import 'package:wiki_project/wiki/ui/markdown_render.dart';
import 'package:wiki_project/wiki/ui/table_of_contents.dart';

final backgroundColor = Colors.white;

class Page extends StatelessWidget {
  final String fileName;

  Page({super.key, required this.fileName});

  final TocController tocController = TocController();

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
            SizedBox(width: 250, child: Sidebar(routes: routes)),
            SizedBox(
              width: 250,
              child: TableOfContents(tocController: tocController),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: MarkdownRender(
                  fileName: fileName,
                  tocController: tocController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
