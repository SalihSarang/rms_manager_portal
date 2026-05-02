import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/repositories/order_repository.dart';
import '../../../table_management/domain/repositories/table_repository.dart';
import '../../../table_management/domain/repositories/hall_repository.dart';
import 'package:rms_shared_package/models/table_models/hall_model.dart';
import 'reports_event.dart';
import 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ITableRepository _tableRepository;
  final IOrderRepository _orderRepository;
  final IHallRepository _hallRepository;
  StreamSubscription? _reportsSubscription;

  ReportsBloc({
    required ITableRepository tableRepository,
    required IOrderRepository orderRepository,
    required IHallRepository hallRepository,
  }) : _tableRepository = tableRepository,
       _orderRepository = orderRepository,
       _hallRepository = hallRepository,
       super(ReportsInitial()) {
    on<FetchReportsData>(_onFetchReportsData);
    on<SelectHall>(_onSelectHall);
    on<_UpdateReportsState>(_onUpdateReportsState);
    on<_ReportsErrorEvent>(_onReportsError);
  }

  void _onFetchReportsData(
    FetchReportsData event,
    Emitter<ReportsState> emit,
  ) async {
    emit(ReportsLoading());

    await _reportsSubscription?.cancel();

    _reportsSubscription =
        CombineLatestStream.combine3(
          _tableRepository.watchAllTables(),
          _orderRepository.watchLiveOrders(),
          Stream.fromFuture(_hallRepository.getHalls()),
          (
            List<TableModel> tables,
            List<OrderModel> orders,
            List<HallModel> halls,
          ) {
            return _calculateReportsData(tables, orders, halls);
          },
        ).listen(
          (state) => add(_UpdateReportsState(state)),
          onError: (error) => add(_ReportsErrorEvent(error.toString())),
        );
  }

  void _onSelectHall(SelectHall event, Emitter<ReportsState> emit) {
    if (state is ReportsLoaded) {
      final currentState = state as ReportsLoaded;
      emit(
        currentState.copyWith(
          selectedHallId: event.hallId,
          clearHallSelection: event.hallId == null,
        ),
      );
    }
  }

  // Internal events for stream updates
  void _onUpdateReportsState(
    _UpdateReportsState event,
    Emitter<ReportsState> emit,
  ) {
    emit(event.state);
  }

  void _onReportsError(_ReportsErrorEvent event, Emitter<ReportsState> emit) {
    emit(ReportsError(event.message));
  }

  ReportsLoaded _calculateReportsData(
    List<TableModel> tables,
    List<OrderModel> orders,
    List<HallModel> halls,
  ) {
    // 1. Calculate Order Counts and Map Table Orders
    int pending = 0;
    int preparing = 0;
    int ready = 0;
    final Map<String, List<OrderModel>> tableOrders = {};

    for (final order in orders) {
      // Aggregate counts
      switch (order.orderStatus) {
        case OrderStatus.pending:
          pending++;
          break;
        case OrderStatus.preparing:
          preparing++;
          break;
        case OrderStatus.ready:
          ready++;
          break;
        default:
          break;
      }

      // Group orders by table (exclude completed and cancelled ones)
      if (order.orderStatus != OrderStatus.completed &&
          order.orderStatus != OrderStatus.cancelled) {
        if (!tableOrders.containsKey(order.tableId)) {
          tableOrders[order.tableId] = [];
        }
        tableOrders[order.tableId]!.add(order);
      }
    }

    return ReportsLoaded(
      tables: tables,
      halls: halls,
      pendingOrdersCount: pending,
      preparingCount: preparing,
      readyCount: ready,
      tableOrders: tableOrders,
      selectedHallId: state is ReportsLoaded
          ? (state as ReportsLoaded).selectedHallId
          : null,
    );
  }

  @override
  Future<void> close() {
    _reportsSubscription?.cancel();
    return super.close();
  }
}

// Private helper events
class _UpdateReportsState extends ReportsEvent {
  final ReportsLoaded state;
  const _UpdateReportsState(this.state);
  @override
  List<Object?> get props => [state];
}

class _ReportsErrorEvent extends ReportsEvent {
  final String message;
  const _ReportsErrorEvent(this.message);
  @override
  List<Object?> get props => [message];
}
