part of 'table_management_bloc.dart';

abstract class TableManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TableManagementInitial extends TableManagementState {}

class TableManagementLoading extends TableManagementState {}

class TableManagementLoaded extends TableManagementState {
  final List<TableModel> tables;
  TableManagementLoaded(this.tables);

  @override
  List<Object?> get props => [tables];
}

class TableManagementError extends TableManagementState {
  final String message;
  TableManagementError(this.message);

  @override
  List<Object?> get props => [message];
}
