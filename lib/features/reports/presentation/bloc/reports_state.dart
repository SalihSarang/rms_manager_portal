import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
import 'package:rms_shared_package/models/table_models/hall_model.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';

abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object?> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final List<TableModel> tables;
  final List<HallModel> halls;
  final int pendingOrdersCount;
  final int preparingCount;
  final int readyCount;
  final Map<String, List<OrderModel>> tableOrders;
  final String? selectedHallId;

  const ReportsLoaded({
    required this.tables,
    required this.halls,
    required this.pendingOrdersCount,
    required this.preparingCount,
    required this.readyCount,
    required this.tableOrders,
    this.selectedHallId,
  });

  ReportsLoaded copyWith({
    List<TableModel>? tables,
    List<HallModel>? halls,
    int? pendingOrdersCount,
    int? preparingCount,
    int? readyCount,
    Map<String, List<OrderModel>>? tableOrders,
    String? selectedHallId,
    bool clearHallSelection = false,
  }) {
    return ReportsLoaded(
      tables: tables ?? this.tables,
      halls: halls ?? this.halls,
      pendingOrdersCount: pendingOrdersCount ?? this.pendingOrdersCount,
      preparingCount: preparingCount ?? this.preparingCount,
      readyCount: readyCount ?? this.readyCount,
      tableOrders: tableOrders ?? this.tableOrders,
      selectedHallId: clearHallSelection
          ? null
          : (selectedHallId ?? this.selectedHallId),
    );
  }

  @override
  List<Object?> get props => [
    tables,
    halls,
    pendingOrdersCount,
    preparingCount,
    readyCount,
    tableOrders,
    selectedHallId,
  ];
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object?> get props => [message];
}
