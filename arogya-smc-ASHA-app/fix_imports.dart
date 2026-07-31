import 'dart:io';

void main() {
  final dir = Directory('lib/presentation/screens/report/steps');
  if (!dir.existsSync()) {
    print('Directory not found');
    return;
  }
  for (var entity in dir.listSync()) {
    if (entity is File && entity.path.endsWith('.dart')) {
      var content = entity.readAsStringSync();
      content = content.replaceAll('import \'../../../core', 'import \'../../../../core');
      content = content.replaceAll('import \'../../../data', 'import \'../../../../data');
      content = content.replaceAll('import \'../../providers', 'import \'../../../providers');
      entity.writeAsStringSync(content);
      print('Fixed \${entity.path}');
    }
  }
}
