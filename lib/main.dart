import 'package:flutter/material.dart';
import 'package:wiki_project/constants.dart';
import 'package:wiki_project/wiki/routes.dart';

void main() {
  runApp(const WikiPoc());
}

class WikiPoc extends StatelessWidget {
  const WikiPoc({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      theme: ThemeData.light().copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoTransitionsBuilder(),
            TargetPlatform.iOS: NoTransitionsBuilder(),
            TargetPlatform.macOS: NoTransitionsBuilder(),
            TargetPlatform.windows: NoTransitionsBuilder(),
            TargetPlatform.linux: NoTransitionsBuilder(),
          },
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
