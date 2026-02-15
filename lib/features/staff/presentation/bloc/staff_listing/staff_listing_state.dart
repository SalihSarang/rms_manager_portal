part of 'staff_listing_bloc.dart';

sealed class StaffListingState extends Equatable {
  const StaffListingState();

  @override
  List<Object?> get props => [];
}

final class StaffListingInitial extends StaffListingState {}

class StaffListingLoading extends StaffListingState {}

class StaffListingLoaded extends StaffListingState {
  final List<StaffModel> staffs;
  const StaffListingLoaded(this.staffs);
  @override
  List<Object?> get props => [staffs];
}

class StaffListingError extends StaffListingState {
  final String message;
  const StaffListingError(this.message);
  @override
  List<Object?> get props => [message];
}

class StaffListingDetails extends StaffListingState {
  final StaffModel staff;
  const StaffListingDetails(this.staff);
  @override
  List<Object?> get props => [staff];
}
