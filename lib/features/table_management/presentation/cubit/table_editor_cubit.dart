import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../domain/repositories/hall_repository.dart';
import '../../domain/repositories/table_repository.dart';
import 'table_editor_state.dart';

class TableEditorCubit extends Cubit<TableEditorState> {
  final IHallRepository _hallRepository;
  final ITableRepository _tableRepository;

  TableEditorCubit(
    this._hallRepository,
    this._tableRepository,
  ) : super(const TableEditorState()) {
    init();
  }

  /// Initial Load

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final halls = await _hallRepository.getHalls();
      final allTables = await _tableRepository.getAllTables();
      emit(state.copyWith(
        halls: halls,
        allTables: allTables,
        isLoading: false,
      ));
    } catch (e) {
      log('Error loading halls/tables: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Hall Operations

  Future<void> selectHall(HallModel hall) async {
    if (state.selectedHall?.id == hall.id) {
      emit(state.copyWith(isViewing: true, isEditing: false));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));
    try {
      final tablesForHall = await _tableRepository.getTables(hall.id);
      emit(
        state
            .copyWith(
              selectedHall: hall,
              tables: tablesForHall,
              isViewing: true,
              isEditing: false,
              isLoading: false,
            )
            .copyWithSelectedTable(null),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> addHall(String id, String name) async {
    if (state.halls.any((h) => h.id == id)) return;

    final newHall = HallModel(
      id: id,
      name: name,
      createdAt: DateTime.now(),
    );

    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _hallRepository.addHall(newHall);
      final updatedHalls = [...state.halls, newHall];
      emit(state.copyWith(halls: updatedHalls, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void setEditing(bool isEditing) {
    emit(state.copyWith(isEditing: isEditing, isViewing: !isEditing));
  }

  void setViewing(bool isViewing) {
    emit(state.copyWith(isViewing: isViewing, isEditing: !isViewing));
  }

  void resetNavigation() {
    emit(state.copyWith(isEditing: false, isViewing: false));
    // Refresh all tables for the overview count
    init();
  }

  /// Table Operations

  Future<void> addTable(TableModel table) async {
    final hallId = state.selectedHall?.id;
    if (hallId == null) return;

    final tableWithHall = table.copyWith(hallId: hallId);
    
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _tableRepository.addTable(tableWithHall);
      final updatedTables = [...state.tables, tableWithHall];
      emit(state.copyWith(
        tables: updatedTables,
        isLoading: false,
      ));
      emit(state.copyWithSelectedTable(tableWithHall));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateTable(TableModel table) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _tableRepository.updateTable(table);
      final updatedTables = List<TableModel>.from(state.tables);
      final idx = updatedTables.indexWhere((t) => t.id == table.id);
      if (idx != -1) updatedTables[idx] = table;
      
      emit(state.copyWith(
        tables: updatedTables,
        isLoading: false,
      ));
      emit(state.copyWithSelectedTable(table));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> deleteTable(String id) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _tableRepository.deleteTable(id);
      final updatedTables = state.tables.where((t) => t.id != id).toList();
      final newSelected = state.selectedTable?.id == id
          ? null
          : state.selectedTable;
          
      emit(state.copyWith(
        tables: updatedTables,
        selectedTable: newSelected,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void selectTable(TableModel? table) {
    emit(state.copyWithSelectedTable(table));
  }

  Future<void> updateSelectedTablePosition(double dx, double dy) async {
    if (state.selectedTable == null) return;
    final updated = state.selectedTable!.copyWith(
      x: state.selectedTable!.x + dx,
      y: state.selectedTable!.y + dy,
    );
    await updateTable(updated);
  }

  Future<void> updateSelectedTableSeats(int seats) async {
    if (state.selectedTable == null) return;
    await updateTable(state.selectedTable!.copyWith(seats: seats));
  }

  Future<void> renameTable(String id, String newName) async {
    final idx = state.tables.indexWhere((t) => t.id == id);
    if (idx == -1) return;
    final updated = state.tables[idx].copyWith(name: newName);
    await updateTable(updated);
  }

  /// UI State

  void setMode(PlanMode mode) {
    emit(state.copyWith(mode: mode));
  }

  List<Map<String, dynamic>> get tablesJson => state.tables
      .map(
        (t) => {
          'id': t.id,
          'shape': t.shape.name,
          'x': t.x,
          'y': t.y,
          'name': t.name,
          'seatingCapacity': t.seats.toString(),
          'availability': 'available',
        },
      )
      .toList();
}
