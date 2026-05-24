import 'package:equatable/equatable.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';

abstract class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object?> get props => [];
}

class LoadOverviewData extends OverviewEvent {
  final Timeframe timeframe;
  final DateTime? startDate;
  final DateTime? endDate;

  const LoadOverviewData({
    this.timeframe = Timeframe.last7Days,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [timeframe, startDate, endDate];
}

class OverviewUpdated extends OverviewEvent {
  final OverviewData data;
  final Timeframe timeframe;
  final DateTime? startDate;
  final DateTime? endDate;

  const OverviewUpdated({
    required this.data,
    required this.timeframe,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [data, timeframe, startDate, endDate];
}
