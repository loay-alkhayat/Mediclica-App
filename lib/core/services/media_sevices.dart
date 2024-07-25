import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService? _instance;
  MediaService._();
  factory MediaService() => _instance ??= MediaService._();

  final ImagePicker _picker = ImagePicker();

  Future<File?> getImage({required bool fromGallery}) async {
    final XFile? image = await _picker.pickImage(
      source: fromGallery ? ImageSource.gallery : ImageSource.camera,
    );
    final File? file = image != null ? File(image.path) : null;
    return file;
  }
}
