import 'package:equatable/equatable.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object?> get props => [];
}

class FetchReportsData extends ReportsEvent {}

class SelectHall extends ReportsEvent {
  final String? hallId;
  const SelectHall(this.hallId);
  @override
  List<Object?> get props => [hallId];
}
