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
            child: Container(
              padding: const EdgeInsets.all(16),
              child: MarkdownWidget(
                data: content,
                tocController: tocController,
                selectable: true,
                config: MarkdownConfig(
                  configs: [PreConfig(theme: a11yLightTheme)],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 250,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[100],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Conteúdo",
                    style: TextTheme.of(
                      context,
                    ).titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Container(
                      transform: Matrix4.translationValues(-35.0, 0.0, 0.0),
                      child: TocWidget(
                        controller: tocController,
                        tocTextStyle: TextStyle(fontSize: 12),
                        currentTocTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
