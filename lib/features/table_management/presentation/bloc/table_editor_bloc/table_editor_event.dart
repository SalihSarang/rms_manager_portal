import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/rms_shared_package.dart';
import 'table_editor_state.dart';

abstract class TableEditorEvent extends Equatable {
  const TableEditorEvent();

  @override
  List<Object?> get props => [];
}

class TableEditorInit extends TableEditorEvent {}

class TableEditorHallSelected extends TableEditorEvent {
  final HallModel hall;
  const TableEditorHallSelected(this.hall);

  @override
  List<Object?> get props => [hall];
}

class TableEditorHallAdded extends TableEditorEvent {
  final String id;
  final String name;
  const TableEditorHallAdded({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}

class TableEditorEditModeSet extends TableEditorEvent {
  final bool isEditing;
  const TableEditorEditModeSet(this.isEditing);

  @override
  List<Object?> get props => [isEditing];
}

class TableEditorViewModeSet extends TableEditorEvent {
  final bool isViewing;
  const TableEditorViewModeSet(this.isViewing);

  @override
  List<Object?> get props => [isViewing];
}

class TableEditorNavigationReset extends TableEditorEvent {}

class TableEditorTableAdded extends TableEditorEvent {
  final TableModel table;
  const TableEditorTableAdded(this.table);

  @override
  List<Object?> get props => [table];
}

class TableEditorTableUpdated extends TableEditorEvent {
  final TableModel table;
  const TableEditorTableUpdated(this.table);

  @override
  List<Object?> get props => [table];
}

class TableEditorTableDeleted extends TableEditorEvent {
  final String id;
  const TableEditorTableDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class TableEditorTableSelected extends TableEditorEvent {
  final TableModel? table;
  const TableEditorTableSelected(this.table);

  @override
  List<Object?> get props => [table];
}

class TableEditorTablePositionUpdated extends TableEditorEvent {
  final double dx;
  final double dy;
  const TableEditorTablePositionUpdated({required this.dx, required this.dy});

  @override
  List<Object?> get props => [dx, dy];
}

class TableEditorTableSeatsUpdated extends TableEditorEvent {
  final int seats;
  const TableEditorTableSeatsUpdated(this.seats);

  @override
  List<Object?> get props => [seats];
}

class TableEditorTableRenamed extends TableEditorEvent {
  final String id;
  final String newName;
  const TableEditorTableRenamed({required this.id, required this.newName});

  @override
  List<Object?> get props => [id, newName];
}

class TableEditorModeSet extends TableEditorEvent {
  final PlanMode mode;
  const TableEditorModeSet(this.mode);

  @override
  List<Object?> get props => [mode];
}
