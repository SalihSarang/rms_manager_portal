import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_profile_img_picker.dart';
import 'package:manager_portal/features/staff/domain/usecases/add_new_staff.dart';
import 'package:manager_portal/features/staff/domain/usecases/create_staff_user.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

part 'add_staff_event.dart';
part 'add_staff_state.dart';

class AddStaffBloc extends Bloc<AddStaffEvent, AddStaffState> {
  final StaffProfileImgPickerUsecase avatarPicker;
  final AddNewStaff addNewStaff;
  final CreateStaffUser createStaffUser;

  AddStaffBloc({
    required this.avatarPicker,
    required this.addNewStaff,
    required this.createStaffUser,
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
    on<SubmitStaffAddForm>(_onSubmit);
  }

  Future<void> _onAvatarPicked(
    AvatarChanged event,
    Emitter<AddStaffState> emit,
  ) async {
    final file = await avatarPicker.pick();
    if (file != null) {
      print('Picked avatar local path: ${file.path}');
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
        print('Uploading image...');
        avatarUrl = await avatarPicker.upload(pickedFile);
        print('Upload success: $avatarUrl');
      } catch (e) {
        print('Upload failed: $e');
        emit(StaffCreateFailed('Image upload failed: $e'));
        return;
      }
    }

    if (currentState.role == null) {
      emit(const StaffCreateFailed('Please select a role'));
      return;
    }

    try {
      // 1. Create Auth User
      print('Creating auth user for ${currentState.email}...');
      final uid = await createStaffUser(
        email: currentState.email,
        password: currentState.password,
      );
      print('Auth user created with UID: $uid');

      // 2. Create Staff Model
      final newStaff = StaffModel(
        id: uid,
        name: currentState.fullName,
        email: currentState.email,
        phoneNumber: currentState.phoneNumber,
        role: UserRole.values.firstWhere(
          (e) => e.name.toLowerCase() == currentState.role!.toLowerCase(),
          orElse: () => UserRole.waiter,
        ),
        avatar: avatarUrl ?? '', // Handle nullable avatar
        isActive: true,
        lastActive: DateTime.now(),
        // createdAt: DateTime.now(), // Removing if not in model, or adding if missing
      );

      // 3. Save to Firestore
      print('Saving staff to Firestore...');
      await addNewStaff(newStaff);
      print('Staff saved successfully');

      emit(StaffCreated());
    } catch (e) {
      print('Submission failed: $e');
      emit(StaffCreateFailed(e.toString()));
    }
  }
}
