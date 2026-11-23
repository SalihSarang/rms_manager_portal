part of 'staff_listing_bloc.dart';

sealed class StaffListingEvent extends Equatable {
  const StaffListingEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffs extends StaffListingEvent {}

class SearchStaff extends StaffListingEvent {
  final String query;
  const SearchStaff(this.query);

  @override
  List<Object?> get props => [query];
}

class FilterStaffByRole extends StaffListingEvent {
  final String role;
  const FilterStaffByRole(this.role);

  @override
  List<Object?> get props => [role];
}

class SelectStaff extends StaffListingEvent {
  final StaffModel staff;
  const SelectStaff(this.staff);
  @override
  List<Object?> get props => [staff];
}

class DeleteStaff extends StaffListingEvent {
  final StaffModel staff;
  const DeleteStaff(this.staff);
  @override
  List<Object?> get props => [staff];
}

class ToggleStaffStatus extends StaffListingEvent {
  final StaffModel staff;
  const ToggleStaffStatus({required this.staff});

  @override
  List<Object?> get props => [staff];
}
