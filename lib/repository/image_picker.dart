import 'package:image_picker/image_picker.dart';

class ImagePickerRepository {
  Future<XFile?> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return image;
  }
}
