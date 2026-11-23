import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/delete_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_all_staffs.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_staff_details.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/update_staff.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';

part 'staff_listing_event.dart';
part 'staff_listing_state.dart';

/// Business logic component for managing the staff listing state.
///
/// Handles loading all staff members, deleting staff, selecting a staff member
/// for details, and toggling staff active status.
class StaffListingBloc extends Bloc<StaffListingEvent, StaffListingState> {
  /// Use case for fetching all staff members.
  final GetAllStaffs getAllStaffs;

  /// Use case for fetching details of a specific staff member.
  final GetStaffDetails getStaffDetails;

  /// Use case for deleting a staff member.
  final DeleteStaffUsecase deleteStaff;

  /// Use case for updating staff information.
  final UpdateStaffUsecase updateStaff;

  /// Service for managing image deletions in Cloudinary.
  final CloudinaryService cloudinaryService;

  String _currentQuery = '';
  String _currentRole = 'All';

  /// Creates a [StaffListingBloc] with the required dependencies.
  StaffListingBloc({
    required this.getAllStaffs,
    required this.getStaffDetails,
    required this.deleteStaff,
    required this.updateStaff,
    required this.cloudinaryService,
  }) : super(StaffListingInitial()) {
    on<LoadStaffs>((event, emit) async {
      emit(StaffListingLoading());
      try {
        final staffList = await getAllStaffs();
        final validStaffList = staffList
            .where((s) => s != null)
            .cast<StaffModel>()
            .toList();

        final filtered = _filterStaffs(
          allStaffs: validStaffList,
          query: _currentQuery,
          role: _currentRole,
        );

        emit(
          StaffListingLoaded(
            staffs: filtered,
            allStaffs: validStaffList,
            searchQuery: _currentQuery,
            selectedRole: _currentRole,
          ),
        );
      } catch (e) {
        emit(StaffListingError(ErrorHandler.getFriendlyMessage(e)));
      }
    });

    on<SearchStaff>((event, emit) {
      _currentQuery = event.query;
      if (state is StaffListingLoaded) {
        final loaded = state as StaffListingLoaded;
        final currentRole = loaded.selectedRole;
        final filtered = _filterStaffs(
          allStaffs: loaded.allStaffs,
          query: event.query,
          role: currentRole,
        );
        emit(loaded.copyWith(staffs: filtered, searchQuery: event.query));
      }
    });

    on<FilterStaffByRole>((event, emit) {
      _currentRole = event.role;
      if (state is StaffListingLoaded) {
        final loaded = state as StaffListingLoaded;
        final currentQuery = loaded.searchQuery;
        final filtered = _filterStaffs(
          allStaffs: loaded.allStaffs,
          query: currentQuery,
          role: event.role,
        );
        emit(loaded.copyWith(staffs: filtered, selectedRole: event.role));
      }
    });

    on<DeleteStaff>((event, emit) async {
      try {
        if (DemoConfig.isProtectedDemoStaff(event.staff)) {
          emit(
            const StaffListingError(
              'Protected demo staff accounts cannot be deleted.',
            ),
          );
          add(LoadStaffs());
          return;
        }

        if (event.staff.avatar.isNotEmpty) {
          final publicId = CloudinaryService.getPublicIdFromUrl(
            event.staff.avatar,
          );
          if (publicId != null) {
            await cloudinaryService.deleteImage(publicId);
          }
        }
        await deleteStaff(event.staff.id);
        add(LoadStaffs());
      } catch (e) {
        emit(StaffListingError(ErrorHandler.getFriendlyMessage(e)));
        add(LoadStaffs());
      }
    });

    on<SelectStaff>((event, emit) {
      emit(StaffListingDetails(event.staff));
    });

    on<ToggleStaffStatus>((event, emit) async {
      try {
        if (DemoConfig.isProtectedDemoStaff(event.staff)) {
          emit(
            const StaffListingError(
              'Protected demo staff accounts cannot be deactivated.',
            ),
          );
          add(LoadStaffs());
          return;
        }

        final updatedStaff = event.staff.copyWith(
          isActive: !event.staff.isActive,
        );
        await updateStaff(updatedStaff);
        add(LoadStaffs());
      } catch (e) {
        emit(StaffListingError(ErrorHandler.getFriendlyMessage(e)));
        add(LoadStaffs());
      }
    });
  }

  static List<StaffModel> _filterStaffs({
    required List<StaffModel> allStaffs,
    required String? query,
    required String? role,
  }) {
    final cleanQuery = (query ?? '').trim().toLowerCase();
    final cleanRole = (role ?? 'All').trim().toLowerCase();

    return allStaffs.where((staff) {
      // 1. Role match
      if (cleanRole != 'all') {
        final staffRole = staff.role.name.toLowerCase();
        final matchesRole =
            staffRole == cleanRole ||
            (cleanRole == 'cashier' && staffRole == 'billing') ||
            (cleanRole == 'chef' && staffRole == 'kitchen');
        if (!matchesRole) {
          return false;
        }
      }

      // 2. Query match
      if (cleanQuery.isNotEmpty) {
        final nameMatch = staff.name.toLowerCase().contains(cleanQuery);
        final emailMatch = staff.email.toLowerCase().contains(cleanQuery);
        final phoneMatch = staff.phoneNumber.toLowerCase().contains(cleanQuery);
        final roleMatch = staff.role.name.toLowerCase().contains(cleanQuery);
        if (!nameMatch && !emailMatch && !phoneMatch && !roleMatch) {
          return false;
        }
      }

      return true;
    }).toList();
  }
}
