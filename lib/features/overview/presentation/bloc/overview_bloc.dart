import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/overview/data/repositories/mock_overview_repository.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_event.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final MockOverviewRepository repository;

  OverviewBloc({required this.repository}) : super(OverviewInitial()) {
    on<LoadOverviewData>(_onLoadOverviewData);
  }

  Future<void> _onLoadOverviewData(
    LoadOverviewData event,
    Emitter<OverviewState> emit,
  ) async {
    emit(OverviewLoading());
    try {
      final data = await repository.getOverviewData();
      emit(OverviewLoaded(data));
    } catch (e) {
      emit(OverviewError(e.toString()));
    }
  }
}
