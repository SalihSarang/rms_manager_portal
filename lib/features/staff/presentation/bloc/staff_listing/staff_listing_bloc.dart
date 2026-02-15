import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

part 'staff_listing_event.dart';
part 'staff_listing_state.dart';

class StaffListingBloc extends Bloc<StaffListingEvent, StaffListingState> {
  StaffListingBloc() : super(StaffListingInitial()) {
    on<LoadStaffs>((event, emit) {
      // TODO: Implement loading logic
      emit(StaffListingLoading());
      // meaningful placeholder until repository is connected
      emit(StaffListingLoaded([]));
    });

    on<SelectStaff>((event, emit) {
      emit(StaffListingDetails(event.staff));
    });
  }
}
