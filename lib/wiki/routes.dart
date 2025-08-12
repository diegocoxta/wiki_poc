import 'package:go_router/go_router.dart';
import 'layout.dart';
import 'page.dart';
import '../docs_index.g.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        // Home (index.md da raiz)
        GoRoute(
          path: '/',
          builder: (context, state) {
            final homeDoc = docsIndex.firstWhere(
              (d) => d['slug'] == '',
              orElse: () => docsIndex.first,
            );
            return DocPage(fileName: homeDoc['file']!);
          },
        ),

        // Todas as outras rotas
        for (var doc in docsIndex.where((d) => d['slug']!.isNotEmpty))
          GoRoute(
            path: '/docs/${doc['slug']}',
            builder: (context, state) => DocPage(fileName: doc['file']!),
          ),
      ],
    ),
  ],
);
