import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manager_portal/features/staff_management/domain/usecases/get_staff_details.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

part 'staff_details_event.dart';
part 'staff_details_state.dart';

class StaffDetailsBloc extends Bloc<StaffDetailsEvent, StaffDetailsState> {
  final GetStaffDetails _getStaffDetails;

  StaffDetailsBloc({required GetStaffDetails getStaffDetails})
    : _getStaffDetails = getStaffDetails,
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
      emit(StaffDetailsLoaded(staff));
    } catch (e) {
      emit(StaffDetailsError(e.toString()));
    }
  }
}
