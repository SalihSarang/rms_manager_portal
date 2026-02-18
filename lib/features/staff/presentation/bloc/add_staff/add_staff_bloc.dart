import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_profile_img_picker.dart';
import 'package:manager_portal/features/staff/domain/usecases/add_new_staff.dart';
import 'package:manager_portal/features/staff/domain/usecases/create_staff_user.dart';
import 'package:manager_portal/features/staff/domain/usecases/update_staff.dart';
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
  }) : super(AddStaffInitial()) {
    on<OpenAddStaffSidebar>((event, emit) => emit(AddStaffSidebarOpenState()));
    on<CloseAddStaffSidebar>(
      (event, emit) => emit(AddStaffSidebarClosedState()),
    );

    on<FullNameChanged>((event, emit) {
      if (state is StaffEditingState) {
        emit((state as StaffEditingState).copyWith(fullName: event.fullName));
      } else {
        emit(StaffEditingState(fullName: event.fullName));
      }
    });

    on<EmailChanged>((event, emit) {
      if (state is StaffEditingState) {
        emit((state as StaffEditingState).copyWith(email: event.email));
      } else {
        emit(StaffEditingState(email: event.email));
      }
    });

    on<PhoneNumberChanged>((event, emit) {
      if (state is StaffEditingState) {
        emit(
          (state as StaffEditingState).copyWith(phoneNumber: event.phoneNumber),
        );
      } else {
        emit(StaffEditingState(phoneNumber: event.phoneNumber));
      }
    });

    on<PasswordChanged>((event, emit) {
      if (state is StaffEditingState) {
        emit((state as StaffEditingState).copyWith(password: event.password));
      } else {
        emit(StaffEditingState(password: event.password));
      }
    });

    on<StaffRoleChanged>((event, emit) {
      if (state is StaffEditingState) {
        emit((state as StaffEditingState).copyWith(role: event.role));
      } else {
        emit(StaffEditingState(role: event.role));
      }
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
      StaffEditingState(
        fullName: event.staff.name,
        email: event.staff.email,
        phoneNumber: event.staff.phoneNumber,
        role: event.staff.role.name.toUpperCase(),
        avatar: event.staff.avatar,
        isEditing: true,
        staffId: event.staff.id,
        originalStaff: event.staff,
        // password is left empty as we don't know it, and typically don't show it in edit
      ),
    );
    add(OpenAddStaffSidebar());
  }

  Future<void> _onAvatarPicked(
    AvatarChanged event,
    Emitter<AddStaffState> emit,
  ) async {
    final file = await avatarPicker.pick();
    if (file != null) {
      log('Picked avatar local path: ${file.path}');
      if (state is StaffEditingState) {
        emit(
          (state as StaffEditingState).copyWith(
            avatar: file.path,
            pickedFile: file,
          ),
        );
      } else {
        emit(StaffEditingState(avatar: file.path, pickedFile: file));
      }
    }
  }

  Future<void> _onSubmit(
    SubmitStaffAddForm event,
    Emitter<AddStaffState> emit,
  ) async {
    if (state is! StaffEditingState) return;
    final currentState = state as StaffEditingState;

    emit(FormSubmitting());

    String? avatarUrl = currentState.avatar;
    final pickedFile = currentState.pickedFile;

    // Check if we have a picked file that needs uploading
    if (pickedFile != null) {
      try {
        log('Uploading image...');
        avatarUrl = await avatarPicker.upload(pickedFile);
        log('Upload success: $avatarUrl');

        // If editing and we have a new image, we might want to delete the old one
        // But we need the public ID from the old URL.
        // We can do this later or blindly. For now, just uploading new one.
        if (currentState.isEditing &&
            currentState.originalStaff?.avatar.isNotEmpty == true) {
          // Optional: triggering delete of old image could be done here if we want to be clean
        }
      } catch (e) {
        log('Upload failed: $e');
        emit(StaffCreateFailed('Image upload failed: $e'));
        return;
      }
    }

    if (currentState.role == null) {
      emit(const StaffCreateFailed('Please select a role'));
      return;
    }

    try {
      if (currentState.isEditing) {
        // Edit Mode Logic
        log('Updating staff ${currentState.email}...');

        // We generally don't update Auth User email/password here easily without re-auth.
        // So we update Firestore data.

        final updatedStaff = currentState.originalStaff!.copyWith(
          name: currentState.fullName,
          email: currentState.email,
          phoneNumber: currentState.phoneNumber,
          role: UserRole.values.firstWhere(
            (e) => e.name.toLowerCase() == currentState.role!.toLowerCase(),
            orElse: () => UserRole.waiter,
          ),
          avatar: avatarUrl ?? '',
        );

        await updateStaff(updatedStaff);
        log('Staff updated successfully');
        emit(const StaffCreated(wasEditing: true)); // Reusing success state
      } else {
        // Add Mode Logic
        log('Creating auth user for ${currentState.email}...');
        final uid = await createStaffUser(
          email: currentState.email,
          password: currentState.password,
        );
        log('Auth user created with UID: $uid');

        final newStaff = StaffModel(
          id: uid,
          name: currentState.fullName,
          email: currentState.email,
          phoneNumber: currentState.phoneNumber,
          role: UserRole.values.firstWhere(
            (e) {
              log('Checking role: ${e.name} against ${currentState.role}');
              return e.name.toLowerCase() == currentState.role!.toLowerCase();
            },
            orElse: () {
              log(
                'Role match failed for ${currentState.role}, defaulting to waiter',
              );
              return UserRole.waiter;
            },
          ),
          avatar: avatarUrl ?? '',
          isActive: true,
          lastActive: DateTime.now(),
        );

        log('Saving staff to Firestore...');
        await addNewStaff(newStaff);
        log('Staff saved successfully');

        emit(const StaffCreated(wasEditing: false));
      }
    } catch (e) {
      log('Submission failed: $e');
      emit(StaffCreateFailed(e.toString()));
    }
  }
}
