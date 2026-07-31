import 'dart:io';

void main() {
  final dir = Directory('lib/presentation/screens');
  for (var sub in dir.listSync()) {
    if (sub is Directory && !sub.path.endsWith('steps')) {
      for (var entity in sub.listSync()) {
        if (entity is File && entity.path.endsWith('.dart')) {
          var content = entity.readAsStringSync();
          content = content.replaceAll('import \'../../core', 'import \'../../../core');
          content = content.replaceAll('import \'../providers', 'import \'../../providers');
          content = content.replaceAll('import \'../../data', 'import \'../../../data');
          entity.writeAsStringSync(content);
          print('Fixed \${entity.path}');
        }
      }
    }
  }
}
