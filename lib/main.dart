import 'package:flutter/material.dart';
import 'wiki/routes.dart';

void main() {
  runApp(const MyDocsApp());
}

class MyDocsApp extends StatelessWidget {
  const MyDocsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wiki Poc',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
