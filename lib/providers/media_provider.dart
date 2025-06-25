import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smile_checker/repository/image_picker.dart';

class MediaProvider extends ChangeNotifier {
  XFile? selectedImage;
  bool loading = false;

  Future<void> pickImage() async {
    loading = true;
    notifyListeners();
    try {
      selectedImage = await ImagePickerRepository().pickImage();
      notifyListeners();
    } catch (e) {
      selectedImage = null;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
