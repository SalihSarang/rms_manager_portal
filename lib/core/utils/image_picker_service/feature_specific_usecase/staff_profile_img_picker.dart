import 'package:manager_portal/core/utils/image_picker_service/image_picker_usecase/image_picker_usecase.dart';

class StaffProfileImgPickerUsecase {
  final ImagePickerUsecase base;

  StaffProfileImgPickerUsecase({required this.base});

  Future<String?> call() {
    return base(folder: 'staff_profile');
  }
}
