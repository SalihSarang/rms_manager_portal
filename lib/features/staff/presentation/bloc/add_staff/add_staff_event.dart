part of 'add_staff_bloc.dart';

sealed class AddStaffEvent extends Equatable {
  const AddStaffEvent();

  @override
  List<Object?> get props => [];
}

class FullNameChanged extends AddStaffEvent {
  final String fullName;
  const FullNameChanged(this.fullName);
  @override
  List<Object?> get props => [fullName];
}

class EmailChanged extends AddStaffEvent {
  final String email;
  const EmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class PhoneNumberChanged extends AddStaffEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class PasswordChanged extends AddStaffEvent {
  final String password;
  const PasswordChanged(this.password);
  @override
  List<Object?> get props => [password];
}

class StaffRoleChanged extends AddStaffEvent {
  final String role;
  const StaffRoleChanged(this.role);
  @override
  List<Object?> get props => [role];
}

class AvatarChanged extends AddStaffEvent {}

class SubmitStaffAddForm extends AddStaffEvent {}

class OpenAddStaffSidebar extends AddStaffEvent {}

class CloseAddStaffSidebar extends AddStaffEvent {}
