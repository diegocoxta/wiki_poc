import 'package:go_router/go_router.dart';
import 'package:wiki_project/docs_index.g.dart';
import 'package:wiki_project/wiki/ui/page.dart';

final appRouter = GoRouter(
  routes: [
    for (var doc in docsIndex)
      GoRoute(
        path: doc['slug'] == '' ? '/' : '/${doc['slug']}',
        builder: (context, state) => Page(fileName: doc['file']!),
      ),
  ],
);
