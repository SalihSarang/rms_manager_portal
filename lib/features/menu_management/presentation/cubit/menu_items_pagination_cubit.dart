import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemsPaginationCubit extends Cubit<int> {
  MenuItemsPaginationCubit() : super(1);

  void goToPage(int page) => emit(page);

  /// Clamps the current page so it never exceeds the last available page.
  void clampPage(int totalPages) {
    if (totalPages > 0 && state > totalPages) {
      emit(totalPages);
    }
  }
}
