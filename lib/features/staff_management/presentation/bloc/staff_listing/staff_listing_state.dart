part of 'staff_listing_bloc.dart';

sealed class StaffListingState extends Equatable {
  const StaffListingState();

  @override
  List<Object?> get props => [];
}

final class StaffListingInitial extends StaffListingState {}

class StaffListingLoading extends StaffListingState {}

class StaffListingLoaded extends StaffListingState {
  /// All staff members loaded from database
  final List<StaffModel> allStaffs;

  /// Filtered and searched staff members to be displayed
  final List<StaffModel> staffs;

  /// Current search query
  final String searchQuery;

  /// Current selected role filter ('All', 'Chef', 'Waiter', 'Cashier')
  final String selectedRole;

  const StaffListingLoaded({
    required this.staffs,
    required this.allStaffs,
    this.searchQuery = '',
    this.selectedRole = 'All',
  });

  @override
  List<Object?> get props => [allStaffs, staffs, searchQuery, selectedRole];

  StaffListingLoaded copyWith({
    List<StaffModel>? allStaffs,
    List<StaffModel>? staffs,
    String? searchQuery,
    String? selectedRole,
  }) {
    return StaffListingLoaded(
      staffs: staffs ?? this.staffs,
      allStaffs: allStaffs ?? this.allStaffs,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedRole: selectedRole ?? this.selectedRole,
    );
  }
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
