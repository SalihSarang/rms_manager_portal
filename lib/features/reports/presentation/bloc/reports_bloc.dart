import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/repositories/order_repository.dart';
import '../../../table_management/domain/repositories/table_repository.dart';
import 'reports_event.dart';
import 'reports_state.dart';

class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final ITableRepository _tableRepository;
  final IOrderRepository _orderRepository;
  StreamSubscription? _reportsSubscription;

  ReportsBloc({
    required ITableRepository tableRepository,
    required IOrderRepository orderRepository,
  }) : _tableRepository = tableRepository,
       _orderRepository = orderRepository,
       super(ReportsInitial()) {
    on<FetchReportsData>(_onFetchReportsData);
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
        CombineLatestStream.combine2(
          _tableRepository.watchAllTables(),
          _orderRepository.watchLiveOrders(),
          (List<TableModel> tables, List<OrderModel> orders) {
            return _calculateReportsData(tables, orders);
          },
        ).listen(
          (state) => add(_UpdateReportsState(state)),
          onError: (error) => add(_ReportsErrorEvent(error.toString())),
        );
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

      // Group orders by table
      if (!tableOrders.containsKey(order.tableId)) {
        tableOrders[order.tableId] = [];
      }
      tableOrders[order.tableId]!.add(order);
    }

    return ReportsLoaded(
      tables: tables,
      pendingOrdersCount: pending,
      preparingCount: preparing,
      readyCount: ready,
      tableOrders: tableOrders,
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
