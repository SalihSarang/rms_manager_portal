part of 'staff_details_bloc.dart';

abstract class StaffDetailsState extends Equatable {
  const StaffDetailsState();

  @override
  List<Object> get props => [];
}

class StaffDetailsInitial extends StaffDetailsState {}

class StaffDetailsLoading extends StaffDetailsState {}

class StaffDetailsLoaded extends StaffDetailsState {
  final StaffModel staff;
  final List<ShiftSession> shiftHistory;

  const StaffDetailsLoaded(this.staff, {this.shiftHistory = const []});

  @override
  List<Object> get props => [staff, shiftHistory];
}

class StaffDetailsError extends StaffDetailsState {
  final String message;

  const StaffDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
