import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

enum PlanMode { select }

class TableEditorState extends Equatable {
  final List<HallModel> halls;
  final HallModel? selectedHall;
  final List<TableModel> allTables; // Master list
  final List<TableModel> tables; // Filtered for current hall
  final TableModel? selectedTable;
  final PlanMode mode;
  final bool isEditing;
  final bool isViewing;
  final bool isLoading;
  final String? error;

  const TableEditorState({
    this.halls = const [],
    this.selectedHall,
    this.allTables = const [],
    this.tables = const [],
    this.selectedTable,
    this.mode = PlanMode.select,
    this.isEditing = false,
    this.isViewing = false,
    this.isLoading = false,
    this.error,
  });

  TableEditorState copyWith({
    List<HallModel>? halls,
    HallModel? selectedHall,
    List<TableModel>? allTables,
    List<TableModel>? tables,
    TableModel? selectedTable,
    PlanMode? mode,
    bool? isEditing,
    bool? isViewing,
    bool? isLoading,
    String? error,
  }) {
    return TableEditorState(
      halls: halls ?? this.halls,
      selectedHall: selectedHall ?? this.selectedHall,
      allTables: allTables ?? this.allTables,
      tables: tables ?? this.tables,
      selectedTable: selectedTable ?? this.selectedTable,
      mode: mode ?? this.mode,
      isEditing: isEditing ?? this.isEditing,
      isViewing: isViewing ?? this.isViewing,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  // To properly handle nulling out the selected table
  TableEditorState copyWithSelectedTable(TableModel? table) {
    return TableEditorState(
      halls: halls,
      selectedHall: selectedHall,
      allTables: allTables,
      tables: tables,
      selectedTable: table,
      mode: mode,
      isEditing: isEditing,
      isViewing: isViewing,
      isLoading: isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    halls,
    selectedHall,
    allTables,
    tables,
    selectedTable,
    mode,
    isEditing,
    isViewing,
    isLoading,
    error,
  ];
}
