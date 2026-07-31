import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class ImageUtilityService {
  final ImagePicker _picker = ImagePicker();
  final _uuid = const Uuid();

  Future<String?> capturePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 70, // Compression
    );
    
    if (photo != null) {
      return await _saveToLocal(File(photo.path));
    }
    return null;
  }

  Future<String?> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 70,
    );
    
    if (image != null) {
      return await _saveToLocal(File(image.path));
    }
    return null;
  }

  Future<String> _saveToLocal(File file) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/photos';
    await Directory(path).create(recursive: true);
    
    final fileName = '${_uuid.v4()}.jpg';
    final savedFile = await file.copy('$path/$fileName');
    return savedFile.path;
  }
}
