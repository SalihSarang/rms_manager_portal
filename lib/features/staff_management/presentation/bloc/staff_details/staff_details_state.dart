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

  const StaffDetailsLoaded(this.staff);

  @override
  List<Object> get props => [staff];
}

class StaffDetailsError extends StaffDetailsState {
  final String message;

  const StaffDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
