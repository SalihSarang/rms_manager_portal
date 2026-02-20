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
  final XFile? pickedFile;
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
    this.pickedFile,
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
    XFile? pickedFile,
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
      pickedFile: pickedFile ?? this.pickedFile,
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
    pickedFile,
    errorMessage,
    originalStaff,
  ];
}
