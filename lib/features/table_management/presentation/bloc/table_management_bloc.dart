import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manager_portal/core/utils/error_handler.dart';
import 'package:manager_portal/features/table_management/domain/usecases/add_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/delete_table_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/get_tables_usecase.dart';
import 'package:manager_portal/features/table_management/domain/usecases/update_table_usecase.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

part 'table_management_event.dart';
part 'table_management_state.dart';

/// Business logic component for managing restaurant tables.
class TableManagementBloc extends Bloc<TableManagementEvent, TableManagementState> {
  final GetTablesUseCase getTablesUseCase;
  final AddTableUseCase addTableUseCase;
  final UpdateTableUseCase updateTableUseCase;
  final DeleteTableUseCase deleteTableUseCase;

  TableManagementBloc({
    required this.getTablesUseCase,
    required this.addTableUseCase,
    required this.updateTableUseCase,
    required this.deleteTableUseCase,
  }) : super(TableManagementInitial()) {
    on<LoadTables>(_onLoadTables);
    on<AddTable>(_onAddTable);
    on<UpdateTable>(_onUpdateTable);
    on<DeleteTable>(_onDeleteTable);
  }

  Future<void> _onLoadTables(
    LoadTables event,
    Emitter<TableManagementState> emit,
  ) async {
    emit(TableManagementLoading());
    try {
      final tables = await getTablesUseCase();
      emit(TableManagementLoaded(tables));
    } catch (e) {
      emit(TableManagementError(ErrorHandler.getFriendlyMessage(e)));
    }
  }

  Future<void> _onAddTable(
    AddTable event,
    Emitter<TableManagementState> emit,
  ) async {
    try {
      await addTableUseCase(event.table);
      add(LoadTables());
    } catch (e) {
      emit(TableManagementError(ErrorHandler.getFriendlyMessage(e)));
    }
  }

  Future<void> _onUpdateTable(
    UpdateTable event,
    Emitter<TableManagementState> emit,
  ) async {
    try {
      await updateTableUseCase(event.table);
      add(LoadTables());
    } catch (e) {
      emit(TableManagementError(ErrorHandler.getFriendlyMessage(e)));
    }
  }

  Future<void> _onDeleteTable(
    DeleteTable event,
    Emitter<TableManagementState> emit,
  ) async {
    try {
      await deleteTableUseCase(event.tableId);
      add(LoadTables());
    } catch (e) {
      emit(TableManagementError(ErrorHandler.getFriendlyMessage(e)));
    }
  }
}
