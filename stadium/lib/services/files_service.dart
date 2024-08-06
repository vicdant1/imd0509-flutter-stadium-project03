import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return File(pickedImage.path);
  }
  return null;
}

Future<File?> pickImageFromFolders() async {
  final pickedFile = await FilePicker.platform.pickFiles(type: FileType.image);
  if (pickedFile != null) {
    return File(pickedFile.files.single.path ?? '');
  }
  return null;
}

Future<File?> captureImageFromCamera() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.camera);
  if (pickedImage != null) {
    return File(pickedImage.path);
  }
  return null;
}

Future<String> convertFiletoBase64(String path) async {
  final file = File(path);
  if (await file.exists()) {
    List<int> bytes = await file.readAsBytes();
    String base64Image = base64Encode(bytes);
    return base64Image;
    // Use the base64Image as needed
  } else {
    print('File does not exist');
    return '';
  }
}
