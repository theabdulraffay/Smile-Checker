import 'package:image_picker/image_picker.dart';

class ImagePickerRepository {
  Future<XFile?> pickImage(ImageSource src) async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(source: src);
    return image;
  }
}
