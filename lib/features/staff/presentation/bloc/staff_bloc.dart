import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_profile_img_picker.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final StaffProfileImgPickerUsecase avatarPicker;

  StaffBloc({required this.avatarPicker}) : super(StaffInitial()) {
    on<StaffEvent>((event, emit) {});

    on<AvatarChanged>(_onAvatarPiting);
  }

  void _onAvatarPiting(AvatarChanged event, Emitter<StaffState> emit) {
    emit(LoadingState());

    final path = avatarPicker.call();
  }
}
