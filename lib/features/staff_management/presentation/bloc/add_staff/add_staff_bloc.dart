import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/utils/error_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_id_proof_picker.dart';
import 'package:manager_portal/core/utils/image_picker_service/feature_specific_usecase/staff_profile_img_picker.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/add_new_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/create_staff_user.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/update_staff.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

part 'add_staff_event.dart';
part 'add_staff_state.dart';

/// Business logic component for adding and editing staff members.
///
/// Manages the state of the staff form, including profile image picking,
/// ID proof picking, and interacting with authentication and storage services.
class AddStaffBloc extends Bloc<AddStaffEvent, AddStaffState> {
  /// Service for picking and uploading staff profile images.
  final StaffProfileImgPickerUsecase avatarPicker;

  /// Service for picking and uploading staff identity proof images.
  final StaffIdProofPickerUsecase idProofPicker;

  /// Use case for saving a new staff member to the backend.
  final AddNewStaff addNewStaff;

  /// Use case for creating a new user account for the staff member.
  final CreateStaffUser createStaffUser;

  /// Use case for updating an existing staff member's information.
  final UpdateStaffUsecase updateStaff;

  /// Service for general Cloudinary operations.
  final CloudinaryService cloudinaryService;

  /// Creates an [AddStaffBloc] with the required services and use cases.
  AddStaffBloc({
    required this.avatarPicker,
    required this.idProofPicker,
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
          baseWage: '',
          wageType: null,
          avatar: '',
          idProof: '',
          bankName: '',
          accountNumber: '',
          ifscCode: '',
          upiId: '',
          pickedFile: null,
          pickedIdProof: null,
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

    on<BaseWageChanged>((event, emit) {
      emit(state.copyWith(baseWage: event.baseWage));
    });

    on<WageTypeChanged>((event, emit) {
      emit(state.copyWith(wageType: event.wageType));
    });
    on<BankNameChanged>((event, emit) {
      emit(state.copyWith(bankName: event.bankName));
    });
    on<AccountNumberChanged>((event, emit) {
      emit(state.copyWith(accountNumber: event.accountNumber));
    });
    on<IfscCodeChanged>((event, emit) {
      emit(state.copyWith(ifscCode: event.ifscCode));
    });
    on<UpiIdChanged>((event, emit) {
      emit(state.copyWith(upiId: event.upiId));
    });

    on<AvatarChanged>(_onAvatarPicked);
    on<IdProofChanged>(_onIdProofPicked);
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
        baseWage: event.staff.baseWage?.toString() ?? '',
        wageType: event.staff.wageType,
        avatar: event.staff.avatar,
        idProof: event.staff.idProof,
        bankName: event.staff.bankDetails?['bankName'] ?? '',
        accountNumber: event.staff.bankDetails?['accountNumber'] ?? '',
        ifscCode: event.staff.bankDetails?['ifscCode'] ?? '',
        upiId: event.staff.bankDetails?['upiId'] ?? '',
        originalStaff: event.staff,
        password: '',
        pickedFile: null,
        pickedIdProof: null,
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

  Future<void> _onIdProofPicked(
    IdProofChanged event,
    Emitter<AddStaffState> emit,
  ) async {
    final file = await idProofPicker.pick();
    if (file != null) {
      log('Picked ID proof local path: ${file.path}');
      emit(state.copyWith(idProof: file.path, pickedIdProof: file));
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

      if (state.mode == AddStaffMode.edit) {
        String? avatarUrl = await _uploadImageIfNeeded(
          state.avatar,
          state.pickedFile,
          isAvatar: true,
        );
        String? idProofUrl = await _uploadImageIfNeeded(
          state.idProof,
          state.pickedIdProof,
          isAvatar: false,
        );
        await _handleUpdateStaff(avatarUrl, idProofUrl);
        emit(state.copyWith(status: AddStaffStatus.success));
      } else {
        await _handleCreateStaff();
        emit(state.copyWith(status: AddStaffStatus.success));
      }
    } catch (e) {
      log('Submission failed: $e');
      emit(
        state.copyWith(
          status: AddStaffStatus.failure,
          errorMessage: ErrorHandler.getFriendlyMessage(e),
        ),
      );
    }
  }

  Future<String?> _uploadImageIfNeeded(
    String currentUrl,
    XFile? pickedFile, {
    required bool isAvatar,
  }) async {
    if (pickedFile != null) {
      log('Uploading ${isAvatar ? 'avatar' : 'ID proof'} image...');
      final url = isAvatar
          ? await avatarPicker.upload(pickedFile)
          : await idProofPicker.upload(pickedFile);
      log('Upload success: $url');
      return url;
    }
    return currentUrl.isNotEmpty ? currentUrl : null;
  }

  Future<void> _handleUpdateStaff(String? avatarUrl, String? idProofUrl) async {
    log('Updating staff ${state.email}...');
    final updatedStaff = state.originalStaff!.copyWith(
      name: state.fullName,
      email: state.email,
      phoneNumber: state.phoneNumber,
      role: state.role!,
      baseWage: double.tryParse(state.baseWage),
      wageType: state.wageType,
      avatar: avatarUrl ?? '',
      idProof: idProofUrl ?? '',
      bankDetails: {
        'bankName': state.bankName,
        'accountNumber': state.accountNumber,
        'ifscCode': state.ifscCode,
        'upiId': state.upiId,
      },
    );

    await updateStaff(updatedStaff);
    log('Staff updated successfully');
  }

  Future<void> _handleCreateStaff() async {
    log('Creating auth user for ${state.email}...');
    final uid = await createStaffUser(
      email: state.email,
      password: state.password,
    );
    log('Auth user created with UID: $uid');

    String? avatarUrl = await _uploadImageIfNeeded(
      state.avatar,
      state.pickedFile,
      isAvatar: true,
    );

    String? idProofUrl = await _uploadImageIfNeeded(
      state.idProof,
      state.pickedIdProof,
      isAvatar: false,
    );

    final newStaff = StaffModel(
      id: uid,
      name: state.fullName,
      email: state.email,
      phoneNumber: state.phoneNumber,
      role: state.role!,
      baseWage: double.tryParse(state.baseWage),
      wageType: state.wageType,
      avatar: avatarUrl ?? '',
      idProof: idProofUrl ?? '',
      isActive: true,
      lastActive: DateTime.now(),
      bankDetails: {
        'bankName': state.bankName,
        'accountNumber': state.accountNumber,
        'ifscCode': state.ifscCode,
        'upiId': state.upiId,
      },
    );

    log('Saving staff to Firestore...');
    await addNewStaff(newStaff);
    log('Staff saved successfully');
  }
}
