import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:wiki_project/constants.dart';

class MarkdownRender extends StatefulWidget {
  final String fileName;
  final TocController tocController;

  const MarkdownRender({
    super.key,
    required this.fileName,
    required this.tocController,
  });

  @override
  State<MarkdownRender> createState() => _MarkdownRenderState();
}

class _MarkdownRenderState extends State<MarkdownRender> {
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
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: MarkdownWidget(
                data: content,
                tocController: widget.tocController,
                selectable: true,
                config: MarkdownConfig(
                  configs: [PreConfig(theme: a11yLightTheme)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
