import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<XFile?> pickImage();
}

class ImagePickerImpl implements ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> pickImage() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }
}
