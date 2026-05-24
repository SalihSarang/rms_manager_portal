part of 'add_staff_bloc.dart';

enum AddStaffStatus { initial, open, loading, success, failure }

enum AddStaffMode { add, edit }

class AddStaffState extends Equatable {
  final AddStaffStatus status;
  final AddStaffMode mode;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final UserRole? role;
  final String avatar;
  final String idProof;
  final XFile? pickedFile;
  final XFile? pickedIdProof;
  final String? errorMessage;
  final StaffModel? originalStaff;

  const AddStaffState({
    this.status = AddStaffStatus.initial,
    this.mode = AddStaffMode.add,
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.role,
    this.avatar = '',
    this.idProof = '',
    this.pickedFile,
    this.pickedIdProof,
    this.errorMessage,
    this.originalStaff,
  });

  AddStaffState copyWith({
    AddStaffStatus? status,
    AddStaffMode? mode,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    UserRole? role,
    String? avatar,
    String? idProof,
    XFile? pickedFile,
    XFile? pickedIdProof,
    String? errorMessage,
    StaffModel? originalStaff,
  }) {
    return AddStaffState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      idProof: idProof ?? this.idProof,
      pickedFile: pickedFile ?? this.pickedFile,
      pickedIdProof: pickedIdProof ?? this.pickedIdProof,
      errorMessage: errorMessage ?? this.errorMessage,
      originalStaff: originalStaff ?? this.originalStaff,
    );
  }

  @override
  List<Object?> get props => [
    status,
    mode,
    fullName,
    email,
    phoneNumber,
    password,
    role,
    avatar,
    idProof,
    pickedFile,
    pickedIdProof,
    errorMessage,
    originalStaff,
  ];
}
