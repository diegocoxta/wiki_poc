import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class TableOfContents extends StatelessWidget {
  final TocController tocController;

  const TableOfContents({super.key, required this.tocController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[100],
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
    );
  }
}
