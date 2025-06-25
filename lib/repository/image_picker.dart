import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerRepository {
  Future<File?> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
