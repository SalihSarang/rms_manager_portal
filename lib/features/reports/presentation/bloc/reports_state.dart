import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/table_models/table_model.dart';
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
  final int pendingOrdersCount;
  final int preparingCount;
  final int readyCount;
  final Map<String, List<OrderModel>> tableOrders;

  const ReportsLoaded({
    required this.tables,
    required this.pendingOrdersCount,
    required this.preparingCount,
    required this.readyCount,
    required this.tableOrders,
  });

  @override
  List<Object?> get props => [
    tables,
    pendingOrdersCount,
    preparingCount,
    readyCount,
    tableOrders,
  ];
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError(this.message);

  @override
  List<Object?> get props => [message];
}
