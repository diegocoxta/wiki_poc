import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../constants.dart';

class DocPage extends StatefulWidget {
  final String fileName;
  const DocPage({super.key, required this.fileName});

  @override
  State<DocPage> createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  String content = '';

  @override
  void initState() {
    super.initState();
    loadMarkdown();
  }

  Future<void> loadMarkdown() async {
    try {
      final text = await rootBundle.loadString('$docsDir/${widget.fileName}');
      setState(() {
        content = text;
      });
    } catch (e) {
      setState(() {
        content = '# Erro\nDocumento não encontrado.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownWidget(
      data: content,
      selectable: true,
      config: MarkdownConfig(configs: [PreConfig(theme: a11yLightTheme)]),
    );
  }
}
