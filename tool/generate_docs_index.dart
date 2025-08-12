import 'dart:io';
import 'package:path/path.dart' as p;

void main() {
  final docsDir = Directory('assets/docs');

  final files = docsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.toLowerCase().endsWith('.md'))
      .toList();

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED FILE — do not edit manually.');
  buffer.writeln('final List<Map<String, String>> docsIndex = [');

  for (final file in files) {
    final relativePath = p.relative(file.path, from: 'assets/docs');
    final cleanPath = relativePath.replaceAll('\\', '/');

    // Tira extensão .md
    String slug = cleanPath.replaceAll(
      RegExp(r'\.md$', caseSensitive: false),
      '',
    );

    // Se for index.md na raiz => slug vazio (home)
    if (cleanPath.toLowerCase() == 'index.md') {
      slug = '';
    }
    // Se for index.md em subpasta => slug vira o nome da pasta
    else if (p.basename(cleanPath).toLowerCase() == 'index.md') {
      slug = p.dirname(cleanPath).replaceAll('\\', '/');
    }

    // Título = primeira linha ou nome
    final firstLine = File(file.path).readAsLinesSync().firstWhere(
      (line) => line.trim().isNotEmpty,
      orElse: () => slug.isEmpty ? 'Home' : slug,
    );
    final title = firstLine.replaceFirst(RegExp(r'^#'), '').trim();

    buffer.writeln(
      "  {'title': '$title', 'file': '$relativePath', 'slug': '$slug'},",
    );
  }

  buffer.writeln('];');
  File('lib/docs_index.g.dart').writeAsStringSync(buffer.toString());
  print('✅ docs_index.g.dart atualizado com ${files.length} arquivos.');
}
