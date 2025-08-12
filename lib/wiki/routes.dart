import 'package:go_router/go_router.dart';
import 'package:wiki_project/wiki/template.dart';
import 'package:wiki_project/wiki/markdown_page_render.dart';
import 'package:wiki_project/docs_index.g.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => Template(child: child),
      routes: [
        for (var doc in docsIndex)
          GoRoute(
            path: doc['slug'] == '' ? '/' : '/${doc['slug']}',
            builder: (context, state) =>
                MarkdownPageRender(fileName: doc['file']!),
          ),
      ],
    ),
  ],
);
