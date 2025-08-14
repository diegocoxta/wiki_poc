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
  final TocController tocController = TocController();

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
            child: MarkdownWidget(
              data: content,
              tocController: tocController,
              selectable: true,
              config: MarkdownConfig(
                configs: [PreConfig(theme: a11yLightTheme)],
              ),
            ),
          ),
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Conteúdo",
                    style: TextTheme.of(context).titleLarge,
                  ),
                ),
                Expanded(child: TocWidget(controller: tocController)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
