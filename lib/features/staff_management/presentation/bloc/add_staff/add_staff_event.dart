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
  List<Object> get props => [password];
}

class StaffRoleChanged extends AddStaffEvent {
  final UserRole role;
  const StaffRoleChanged(this.role);
  @override
  List<Object> get props => [role];
}

class BaseWageChanged extends AddStaffEvent {
  final String baseWage;
  const BaseWageChanged(this.baseWage);
  @override
  List<Object> get props => [baseWage];
}

class WageTypeChanged extends AddStaffEvent {
  final WageType wageType;
  const WageTypeChanged(this.wageType);
  @override
  List<Object> get props => [wageType];
}

class AvatarChanged extends AddStaffEvent {}

class IdProofChanged extends AddStaffEvent {}

class BankNameChanged extends AddStaffEvent {
  final String bankName;
  const BankNameChanged(this.bankName);
  @override
  List<Object> get props => [bankName];
}

class AccountNumberChanged extends AddStaffEvent {
  final String accountNumber;
  const AccountNumberChanged(this.accountNumber);
  @override
  List<Object> get props => [accountNumber];
}

class IfscCodeChanged extends AddStaffEvent {
  final String ifscCode;
  const IfscCodeChanged(this.ifscCode);
  @override
  List<Object> get props => [ifscCode];
}

class UpiIdChanged extends AddStaffEvent {
  final String upiId;
  const UpiIdChanged(this.upiId);
  @override
  List<Object> get props => [upiId];
}

class SubmitStaffAddForm extends AddStaffEvent {}

class OpenAddStaffSidebar extends AddStaffEvent {}

class InitializeEditMode extends AddStaffEvent {
  final StaffModel staff;
  const InitializeEditMode(this.staff);
  @override
  List<Object> get props => [staff];
}

class CloseAddStaffSidebar extends AddStaffEvent {}
