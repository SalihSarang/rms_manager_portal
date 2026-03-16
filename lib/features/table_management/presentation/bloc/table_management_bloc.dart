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
class TableManagementBloc
    extends Bloc<TableManagementEvent, TableManagementState> {
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

      // For visualization purposes, if no tables exist in Firestore, provide mock data
      if (tables.isEmpty) {
        final mockTables = [
          TableModel(
            id: 1,
            name: 'Table 01',
            capacity: 4,
            status: TableStatus.available,
            shape: TableShape.square,
            currentGuests: 0,
            hallId: 'Main Hall',
            posX: 100,
            posY: 100,
          ),
          TableModel(
            id: 2,
            name: 'Table 02',
            capacity: 2,
            status: TableStatus.occupied,
            shape: TableShape.circle,
            currentGuests: 2,
            hallId: 'Main Hall',
            posX: 300,
            posY: 100,
          ),
          TableModel(
            id: 3,
            name: 'Table 03',
            capacity: 6,
            status: TableStatus.partiallyOccupied,
            shape: TableShape.rectangle,
            currentGuests: 3,
            hallId: 'Main Hall',
            posX: 100,
            posY: 300,
          ),
          TableModel(
            id: 4,
            name: 'Table 04',
            capacity: 4,
            status: TableStatus.disabled,
            shape: TableShape.square,
            currentGuests: 0,
            hallId: 'Main Hall',
            posX: 300,
            posY: 300,
          ),
          TableModel(
            id: 5,
            name: 'VIP 01',
            capacity: 8,
            status: TableStatus.available,
            shape: TableShape.rectangle,
            currentGuests: 0,
            hallId: 'VIP Section',
            posX: 500,
            posY: 100,
          ),
        ];
        emit(TableManagementLoaded(mockTables));
      } else {
        emit(TableManagementLoaded(tables));
      }
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
