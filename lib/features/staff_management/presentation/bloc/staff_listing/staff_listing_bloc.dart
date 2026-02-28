import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/delete_staff.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_all_staffs.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_staff_details.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/update_staff.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/core/utils/image_picker_service/cloudinary_service/cloudinary_service.dart';

part 'staff_listing_event.dart';
part 'staff_listing_state.dart';

class StaffListingBloc extends Bloc<StaffListingEvent, StaffListingState> {
  final GetAllStaffs getAllStaffs;
  final GetStaffDetails getStaffDetails;
  final DeleteStaffUsecase deleteStaff;
  final UpdateStaffUsecase updateStaff;
  final CloudinaryService cloudinaryService;

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
        emit(StaffListingLoaded(validStaffList));
      } catch (e) {
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
        add(LoadStaffs());
      }
    });

    on<SelectStaff>((event, emit) {
      emit(StaffListingDetails(event.staff));
    });

    on<ToggleStaffStatus>((event, emit) async {
      try {
        final updatedStaff = event.staff.copyWith(
          isActive: !event.staff.isActive,
        );
        await updateStaff(updatedStaff);
        add(LoadStaffs());
      } catch (e) {
        add(LoadStaffs());
      }
    });
  }
}
