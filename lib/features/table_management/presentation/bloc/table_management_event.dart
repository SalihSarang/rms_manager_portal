part of 'table_management_bloc.dart';

abstract class TableManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTables extends TableManagementEvent {}

class AddTable extends TableManagementEvent {
  final TableModel table;
  AddTable(this.table);

  @override
  List<Object?> get props => [table];
}

class UpdateTable extends TableManagementEvent {
  final TableModel table;
  UpdateTable(this.table);

  @override
  List<Object?> get props => [table];
}

class DeleteTable extends TableManagementEvent {
  final int tableId;
  DeleteTable(this.tableId);

  @override
  List<Object?> get props => [tableId];
}
