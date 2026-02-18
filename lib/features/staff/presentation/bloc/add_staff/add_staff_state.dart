part of 'add_staff_bloc.dart';

sealed class AddStaffState extends Equatable {
  const AddStaffState();

  @override
  List<Object?> get props => [];
}

final class AddStaffInitial extends AddStaffState {}

class AddStaffSidebarOpenState extends AddStaffState {}

class AddStaffSidebarClosedState extends AddStaffState {}

class StaffEditingState extends AddStaffState {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? role;
  final String? avatar;
  final XFile? pickedFile;
  final bool isEditing;
  final String? staffId;
  final StaffModel? originalStaff;

  const StaffEditingState({
    this.fullName = "",
    this.email = "",
    this.phoneNumber = "",
    this.password = "",
    this.role,
    this.avatar,
    this.pickedFile,
    this.isEditing = false,
    this.staffId,
    this.originalStaff,
  });

  StaffEditingState copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? password,
    String? role,
    String? avatar,
    XFile? pickedFile,
    bool? isEditing,
    String? staffId,
    StaffModel? originalStaff,
  }) {
    return StaffEditingState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      pickedFile: pickedFile ?? this.pickedFile,
      isEditing: isEditing ?? this.isEditing,
      staffId: staffId ?? this.staffId,
      originalStaff: originalStaff ?? this.originalStaff,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    email,
    phoneNumber,
    password,
    role,
    avatar,
    pickedFile,
    isEditing,
    staffId,
    originalStaff,
  ];
}

class FormSubmitting extends AddStaffState {}

class StaffFormIsInvalid extends AddStaffState {
  final String reason;
  const StaffFormIsInvalid(this.reason);
  @override
  List<Object?> get props => [reason];
}

class StaffCreated extends AddStaffState {
  final bool wasEditing;
  const StaffCreated({this.wasEditing = false});
  @override
  List<Object?> get props => [wasEditing];
}

class StaffCreateFailed extends AddStaffState {
  final String error;
  const StaffCreateFailed(this.error);
  @override
  List<Object?> get props => [error];
}
