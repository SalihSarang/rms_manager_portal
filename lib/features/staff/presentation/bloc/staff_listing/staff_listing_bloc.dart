import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';
import 'package:manager_portal/features/staff/domain/usecases/delete_staff.dart';
import 'package:manager_portal/features/staff/domain/usecases/get_all_staffs.dart';
import 'package:manager_portal/features/staff/domain/usecases/get_staff_details.dart';

part 'staff_listing_event.dart';
part 'staff_listing_state.dart';

class StaffListingBloc extends Bloc<StaffListingEvent, StaffListingState> {
  final GetAllStaffs getAllStaffs;
  final GetStaffDetails getStaffDetails;
  final DeleteStaffUsecase deleteStaff;
  final CloudinaryService cloudinaryService;

  StaffListingBloc({
    required this.getAllStaffs,
    required this.getStaffDetails,
    required this.deleteStaff,
    required this.cloudinaryService,
  }) : super(StaffListingInitial()) {
    on<LoadStaffs>((event, emit) async {
      emit(StaffListingLoading());
      try {
        final staffList = await getAllStaffs();
        // Filter out nulls if any, though repository should handle this
        final validStaffList = staffList
            .where((s) => s != null)
            .cast<StaffModel>()
            .toList();
        emit(StaffListingLoaded(validStaffList));
      } catch (e) {
        // ideally we should have an error state
        emit(StaffListingLoaded(const []));
      }
    });

    on<DeleteStaff>((event, emit) async {
      try {
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
        // Handle error, maybe emit a temporary error state or snackbar via listener
        // For now, reloading to ensure consistency
        add(LoadStaffs());
      }
    });

    on<SelectStaff>((event, emit) {
      emit(StaffListingDetails(event.staff));
    });
  }
}
