import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/image_picker_usecase/image_picker_usecase.dart';

class StaffIdProofPickerUsecase {
  final ImagePickerUsecase base;

  StaffIdProofPickerUsecase({required this.base});

  Future<String?> call() {
    return base(folder: 'staff_id_proof', uploadPreset: 'staff_id_proof');
  }

  Future<XFile?> pick() {
    return base.pickImageOnly();
  }

  Future<String> upload(XFile file) {
    return base.uploadImageOnly(
      file: file,
      folder: 'staff_id_proof',
      uploadPreset: 'staff_id_proof',
    );
  }
}
