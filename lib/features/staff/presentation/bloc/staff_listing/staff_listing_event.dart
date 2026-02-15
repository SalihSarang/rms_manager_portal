part of 'staff_listing_bloc.dart';

sealed class StaffListingEvent extends Equatable {
  const StaffListingEvent();

  @override
  List<Object?> get props => [];
}

class LoadStaffs extends StaffListingEvent {}

class SelectStaff extends StaffListingEvent {
  final StaffModel staff;
  const SelectStaff(this.staff);
  @override
  List<Object?> get props => [staff];
}
