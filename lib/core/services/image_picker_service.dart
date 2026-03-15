import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // Future<List<String>> pickMultiImageFromGallery() async {
  //   final List<XFile> pickedFiles = await _imagePicker.pickMultiImage();
  //   final List<String> filePaths = [];
  //   if (pickedFiles.isNotEmpty) {
  //     for (XFile file in pickedFiles) {
  //       filePaths.add(file.path);
  //     }
  //     return filePaths;
  //   }
  //   return [];
  // }

  Future<File?> pickImageFromCamera() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
