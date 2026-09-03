part of 'staff_details_bloc.dart';

abstract class StaffDetailsEvent extends Equatable {
  const StaffDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchStaffDetails extends StaffDetailsEvent {
  final String staffId;

  const FetchStaffDetails(this.staffId);

  @override
  List<Object> get props => [staffId];
}
