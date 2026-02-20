import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_profile_img_picker.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/add_new_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/create_staff_user.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/update_staff.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

part 'add_staff_event.dart';
part 'add_staff_state.dart';

class AddStaffBloc extends Bloc<AddStaffEvent, AddStaffState> {
  final StaffProfileImgPickerUsecase avatarPicker;
  final AddNewStaff addNewStaff;
  final CreateStaffUser createStaffUser;
  final UpdateStaffUsecase updateStaff;
  final CloudinaryService cloudinaryService;

  AddStaffBloc({
    required this.avatarPicker,
    required this.addNewStaff,
    required this.createStaffUser,
    required this.updateStaff,
    required this.cloudinaryService,
  }) : super(const AddStaffState()) {
    on<OpenAddStaffSidebar>((event, emit) {
      emit(
        state.copyWith(
          status: AddStaffStatus.open,
          mode: AddStaffMode.add,
          fullName: '',
          email: '',
          phoneNumber: '',
          password: '',
          role: null,
          avatar: '',
          pickedFile: null,
          errorMessage: null,
          originalStaff: null,
        ),
      );
    });

    on<CloseAddStaffSidebar>((event, emit) {
      emit(state.copyWith(status: AddStaffStatus.initial));
    });

    on<FullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PhoneNumberChanged>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<StaffRoleChanged>((event, emit) {
      emit(state.copyWith(role: event.role));
    });

    on<AvatarChanged>(_onAvatarPicked);
    on<InitializeEditMode>(_onInitializeEditMode);
    on<SubmitStaffAddForm>(_onSubmit);
  }

  void _onInitializeEditMode(
    InitializeEditMode event,
    Emitter<AddStaffState> emit,
  ) {
    emit(
      state.copyWith(
        status: AddStaffStatus.open,
        mode: AddStaffMode.edit,
        fullName: event.staff.name,
        email: event.staff.email,
        phoneNumber: event.staff.phoneNumber,
        role: event.staff.role,
        avatar: event.staff.avatar,
        originalStaff: event.staff,
        password: '',
        pickedFile: null,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onAvatarPicked(
    AvatarChanged event,
    Emitter<AddStaffState> emit,
  ) async {
    final file = await avatarPicker.pick();
    if (file != null) {
      log('Picked avatar local path: ${file.path}');
      emit(state.copyWith(avatar: file.path, pickedFile: file));
    }
  }

  Future<void> _onSubmit(
    SubmitStaffAddForm event,
    Emitter<AddStaffState> emit,
  ) async {
    emit(state.copyWith(status: AddStaffStatus.loading));

    try {
      if (state.role == null) {
        emit(
          state.copyWith(
            status: AddStaffStatus.failure,
            errorMessage: 'Please select a role',
          ),
        );
        return;
      }

      String? avatarUrl = await _uploadImageIfNeeded(
        state.avatar,
        state.pickedFile,
      );

      if (state.mode == AddStaffMode.edit) {
        await _handleUpdateStaff(avatarUrl);
        emit(state.copyWith(status: AddStaffStatus.success));
      } else {
        await _handleCreateStaff(avatarUrl);
        emit(state.copyWith(status: AddStaffStatus.success));
      }
    } catch (e) {
      log('Submission failed: $e');
      emit(
        state.copyWith(
          status: AddStaffStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<String?> _uploadImageIfNeeded(
    String currentAvatar,
    XFile? pickedFile,
  ) async {
    if (pickedFile != null) {
      log('Uploading image...');
      final url = await avatarPicker.upload(pickedFile);
      log('Upload success: $url');
      return url;
    }
    return currentAvatar.isNotEmpty ? currentAvatar : null;
  }

  Future<void> _handleUpdateStaff(String? avatarUrl) async {
    log('Updating staff ${state.email}...');
    final updatedStaff = state.originalStaff!.copyWith(
      name: state.fullName,
      email: state.email,
      phoneNumber: state.phoneNumber,
      role: state.role!,
      avatar: avatarUrl ?? '',
    );

    await updateStaff(updatedStaff);
    log('Staff updated successfully');
  }

  Future<void> _handleCreateStaff(String? avatarUrl) async {
    log('Creating auth user for ${state.email}...');
    final uid = await createStaffUser(
      email: state.email,
      password: state.password,
    );
    log('Auth user created with UID: $uid');

    final newStaff = StaffModel(
      id: uid,
      name: state.fullName,
      email: state.email,
      phoneNumber: state.phoneNumber,
      role: state.role!,
      avatar: avatarUrl ?? '',
      isActive: true,
      lastActive: DateTime.now(),
    );

    log('Saving staff to Firestore...');
    await addNewStaff(newStaff);
    log('Staff saved successfully');
  }
}
