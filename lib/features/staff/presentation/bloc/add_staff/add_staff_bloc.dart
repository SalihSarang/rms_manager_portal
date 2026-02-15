import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_profile_img_picker.dart';

part 'add_staff_event.dart';
part 'add_staff_state.dart';

class AddStaffBloc extends Bloc<AddStaffEvent, AddStaffState> {
  final StaffProfileImgPickerUsecase avatarPicker;

  AddStaffBloc({required this.avatarPicker}) : super(AddStaffInitial()) {
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

    // Procced with submission using avatarUrl
    print('Submitting form with avatar: $avatarUrl');
    // Call repository to save staff...

    emit(StaffCreated());
  }
}
