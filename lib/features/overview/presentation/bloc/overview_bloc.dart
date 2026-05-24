import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/overview/domain/repositories/overview_repository.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_event.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final OverviewRepository repository;
  StreamSubscription? _subscription;

  OverviewBloc({required this.repository}) : super(OverviewInitial()) {
    on<LoadOverviewData>(_onLoadOverviewData);
    on<OverviewUpdated>(_onOverviewUpdated);
  }

  Future<void> _onLoadOverviewData(
    LoadOverviewData event,
    Emitter<OverviewState> emit,
  ) async {
    emit(OverviewLoading());
    
    // Cancel any existing subscription before starting a new one
    await _subscription?.cancel();
    
    _subscription = repository
        .watchOverviewData(
          event.timeframe,
          startDate: event.startDate,
          endDate: event.endDate,
        )
        .listen(
          (data) => add(OverviewUpdated(
            data: data,
            timeframe: event.timeframe,
            startDate: event.startDate,
            endDate: event.endDate,
          )),
          onError: (error) => addError(error),
        );
  }

  void _onOverviewUpdated(
    OverviewUpdated event,
    Emitter<OverviewState> emit,
  ) {
    emit(OverviewLoaded(
      event.data,
      timeframe: event.timeframe,
      startDate: event.startDate,
      endDate: event.endDate,
    ));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
