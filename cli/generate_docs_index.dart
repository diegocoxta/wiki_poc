import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:wiki_project/constants.dart';

void main() {
  final docsDirConstant = Directory(docsDir);

  final files = docsDirConstant
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.toLowerCase().endsWith('.md'))
      .toList();

  final buffer = StringBuffer();
  buffer.writeln('// GENERATED FILE — do not edit manually.');
  buffer.writeln('final List<Map<String, String>> docsIndex = [');

  for (final file in files) {
    final relativePath = p.relative(file.path, from: docsDir);
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

  // --- ATUALIZAR PUBSPEC COM AS PASTAS ---
  final pubspec = File('pubspec.yaml').readAsStringSync().split('\n');
  final assetIndex = pubspec.indexWhere((line) => line.trim() == 'assets:');
  if (assetIndex != -1) {
    // Encontra todas as pastas únicas
    final folders = {
      'docs/',
      ...files
          .map((f) => 'docs/${p.dirname(p.relative(f.path, from: 'docs'))}/')
          .where((f) => f != 'docs/'),
    };

    // Remove linhas antigas de docs
    pubspec.removeWhere((line) => line.trim().startsWith('- docs/'));

    // Adiciona novamente
    var insertIndex = assetIndex + 1;
    for (final folder in folders) {
      pubspec.insert(insertIndex, '    - $folder');
      insertIndex++;
    }

    File('pubspec.yaml').writeAsStringSync(pubspec.join('\n'));
    print('📄 pubspec.yaml atualizado com pastas de docs.');
  }

  print('✅ docs_index.g.dart atualizado com ${files.length} arquivos.');
}
