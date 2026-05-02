import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import '../../../domain/repositories/hall_repository.dart';
import '../../../domain/repositories/table_repository.dart';
import 'table_editor_event.dart';
import 'table_editor_state.dart';

/// BloC that manages the table editor state and logic.
class TableEditorBloc extends Bloc<TableEditorEvent, TableEditorState> {
  final IHallRepository _hallRepository;
  final ITableRepository _tableRepository;

  TableEditorBloc(this._hallRepository, this._tableRepository)
    : super(const TableEditorState()) {
    on<TableEditorInit>(_onInit);
    on<TableEditorHallSelected>(_onHallSelected);
    on<TableEditorHallAdded>(_onHallAdded);
    on<TableEditorEditModeSet>(_onEditModeSet);
    on<TableEditorViewModeSet>(_onViewModeSet);
    on<TableEditorNavigationReset>(_onNavigationReset);
    on<TableEditorTableAdded>(_onTableAdded);
    on<TableEditorTableUpdated>(_onTableUpdated);
    on<TableEditorTableDeleted>(_onTableDeleted);
    on<TableEditorTableSelected>(_onTableSelected);
    on<TableEditorTablePositionUpdated>(_onTablePositionUpdated);
    on<TableEditorTableSeatsUpdated>(_onTableSeatsUpdated);
    on<TableEditorTableRenamed>(_onTableRenamed);
    on<TableEditorModeSet>(_onModeSet);
    on<TableEditorZoomUpdated>(_onZoomUpdated);
    on<TableEditorViewportSizeUpdated>(_onViewportSizeUpdated);
  }

  /// Initial Load
  /// Performs initial fetch of halls and all tables from repositories.
  Future<void> _onInit(
    TableEditorInit event,
    Emitter<TableEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final halls = await _hallRepository.getHalls();
      final allTables = await _tableRepository.getAllTables();
      emit(
        state.copyWith(halls: halls, allTables: allTables, isLoading: false),
      );
    } catch (e) {
      log('Error loading halls/tables: $e');
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Hall Operations
  /// Handles selection of a hall and loads its associated tables.
  Future<void> _onHallSelected(
    TableEditorHallSelected event,
    Emitter<TableEditorState> emit,
  ) async {
    final hall = event.hall;
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

  /// Adds a new hall to the repository.
  Future<void> _onHallAdded(
    TableEditorHallAdded event,
    Emitter<TableEditorState> emit,
  ) async {
    if (state.halls.any((h) => h.id == event.id)) return;

    final newHall = HallModel(
      id: event.id,
      name: event.name,
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

  /// Toggles editing mode.
  void _onEditModeSet(
    TableEditorEditModeSet event,
    Emitter<TableEditorState> emit,
  ) {
    emit(
      state.copyWith(isEditing: event.isEditing, isViewing: !event.isEditing),
    );
  }

  /// Toggles viewing mode.
  void _onViewModeSet(
    TableEditorViewModeSet event,
    Emitter<TableEditorState> emit,
  ) {
    emit(
      state.copyWith(isViewing: event.isViewing, isEditing: !event.isViewing),
    );
  }

  /// Resets navigation state and re-initializes.
  Future<void> _onNavigationReset(
    TableEditorNavigationReset event,
    Emitter<TableEditorState> emit,
  ) async {
    emit(state.copyWith(isEditing: false, isViewing: false));
    add(TableEditorInit());
  }

  /// Table Operations
  /// Adds a new table to the currently selected hall.
  Future<void> _onTableAdded(
    TableEditorTableAdded event,
    Emitter<TableEditorState> emit,
  ) async {
    final hallId = state.selectedHall?.id;
    if (hallId == null) return;

    final tableWithHall = event.table.copyWith(hallId: hallId);

    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _tableRepository.addTable(tableWithHall);
      final updatedTables = [...state.tables, tableWithHall];
      emit(
        state
            .copyWith(tables: updatedTables, isLoading: false)
            .copyWithSelectedTable(tableWithHall),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Updates an existing table in the repository.
  Future<void> _onTableUpdated(
    TableEditorTableUpdated event,
    Emitter<TableEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _tableRepository.updateTable(event.table);
      final updatedTables = List<TableModel>.from(state.tables);
      final idx = updatedTables.indexWhere((t) => t.id == event.table.id);
      if (idx != -1) updatedTables[idx] = event.table;

      emit(
        state
            .copyWith(tables: updatedTables, isLoading: false)
            .copyWithSelectedTable(event.table),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Deletes a table by ID.
  Future<void> _onTableDeleted(
    TableEditorTableDeleted event,
    Emitter<TableEditorState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _tableRepository.deleteTable(event.id);
      final updatedTables = state.tables
          .where((t) => t.id != event.id)
          .toList();
      final newSelected = state.selectedTable?.id == event.id
          ? null
          : state.selectedTable;

      emit(
        state.copyWith(
          tables: updatedTables,
          selectedTable: newSelected,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Updates the currently selected table in the state.
  void _onTableSelected(
    TableEditorTableSelected event,
    Emitter<TableEditorState> emit,
  ) {
    emit(state.copyWithSelectedTable(event.table));
  }

  /// Updates the position (x, y) of the selected table.
  Future<void> _onTablePositionUpdated(
    TableEditorTablePositionUpdated event,
    Emitter<TableEditorState> emit,
  ) async {
    if (state.selectedTable == null) return;
    final updated = state.selectedTable!.copyWith(
      x: state.selectedTable!.x + event.dx,
      y: state.selectedTable!.y + event.dy,
    );
    add(TableEditorTableUpdated(updated));
  }

  /// Updates the number of seats for the selected table.
  Future<void> _onTableSeatsUpdated(
    TableEditorTableSeatsUpdated event,
    Emitter<TableEditorState> emit,
  ) async {
    if (state.selectedTable == null) return;
    add(
      TableEditorTableUpdated(
        state.selectedTable!.copyWith(seats: event.seats),
      ),
    );
  }

  /// Renames a table.
  Future<void> _onTableRenamed(
    TableEditorTableRenamed event,
    Emitter<TableEditorState> emit,
  ) async {
    final idx = state.tables.indexWhere((t) => t.id == event.id);
    if (idx == -1) return;
    final updated = state.tables[idx].copyWith(name: event.newName);
    add(TableEditorTableUpdated(updated));
  }

  /// UI State
  /// Sets the interaction mode (select, etc.).
  void _onModeSet(TableEditorModeSet event, Emitter<TableEditorState> emit) {
    emit(state.copyWith(mode: event.mode));
  }

  void _onZoomUpdated(
    TableEditorZoomUpdated event,
    Emitter<TableEditorState> emit,
  ) {
    emit(state.copyWith(zoomScale: event.scale));
  }

  void _onViewportSizeUpdated(
    TableEditorViewportSizeUpdated event,
    Emitter<TableEditorState> emit,
  ) {
    emit(state.copyWith(viewportSize: event.size));
  }
}
