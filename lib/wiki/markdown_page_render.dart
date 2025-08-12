import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wiki_project/constants.dart';

class MarkdownPageRender extends StatefulWidget {
  final String fileName;

  const MarkdownPageRender({super.key, required this.fileName});

  @override
  State<MarkdownPageRender> createState() => _MarkdownPageRenderState();
}

class _MarkdownPageRenderState extends State<MarkdownPageRender> {
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
    return Container(
      color: Colors.white,
      child: MarkdownWidget(
        data: content,
        selectable: true,
        config: MarkdownConfig(configs: [PreConfig(theme: a11yLightTheme)]),
      ),
    );
  }
}
