import 'package:flutter_bloc/flutter_bloc.dart';

class StaffPaginationCubit extends Cubit<int> {
  StaffPaginationCubit() : super(1);

  void goToPage(int page) => emit(page);

  /// Call this whenever the staff list changes so the current page
  /// never exceeds the last available page.
  void clampPage(int totalPages) {
    if (totalPages > 0 && state > totalPages) {
      emit(totalPages);
    }
  }
}
