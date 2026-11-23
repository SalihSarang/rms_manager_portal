import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_staff_details.dart';
import 'package:rms_shared_package/models/shift_models/shift_session.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/repositories/shift_repository.dart';

part 'staff_details_event.dart';
part 'staff_details_state.dart';

/// Business logic component for viewing the details of a single staff member.
///
/// Fetches [StaffModel] data and real [ShiftSession] history.
class StaffDetailsBloc extends Bloc<StaffDetailsEvent, StaffDetailsState> {
  final GetStaffDetails _getStaffDetails;
  final ShiftRepository _shiftRepository;

  StaffDetailsBloc({
    required GetStaffDetails getStaffDetails,
    required ShiftRepository shiftRepository,
  }) : _getStaffDetails = getStaffDetails,
       _shiftRepository = shiftRepository,
       super(StaffDetailsInitial()) {
    on<FetchStaffDetails>(_onFetchStaffDetails);
  }

  Future<void> _onFetchStaffDetails(
    FetchStaffDetails event,
    Emitter<StaffDetailsState> emit,
  ) async {
    emit(StaffDetailsLoading());
    try {
      final staff = await _getStaffDetails(event.staffId);
      List<ShiftSession> history = [];
      try {
        history = await _shiftRepository.getShiftHistory(event.staffId);
      } catch (_) {}
      emit(StaffDetailsLoaded(staff, shiftHistory: history));
    } catch (e) {
      emit(StaffDetailsError(e.toString()));
    }
  }
}
