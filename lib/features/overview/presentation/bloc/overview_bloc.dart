import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/overview/domain/repositories/overview_repository.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_event.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final OverviewRepository repository;

  OverviewBloc({required this.repository}) : super(OverviewInitial()) {
    on<LoadOverviewData>(_onLoadOverviewData);
  }

  Future<void> _onLoadOverviewData(
    LoadOverviewData event,
    Emitter<OverviewState> emit,
  ) async {
    emit(OverviewLoading());
    try {
      final data = await repository.getOverviewData(
        event.timeframe,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      emit(OverviewLoaded(
        data,
        timeframe: event.timeframe,
        startDate: event.startDate,
        endDate: event.endDate,
      ));
    } catch (e) {
      emit(OverviewError(e.toString()));
    }
  }
}
