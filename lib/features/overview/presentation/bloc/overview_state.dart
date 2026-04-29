import 'package:equatable/equatable.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';

abstract class OverviewState extends Equatable {
  const OverviewState();

  @override
  List<Object?> get props => [];
}

class OverviewInitial extends OverviewState {}

class OverviewLoading extends OverviewState {}

class OverviewLoaded extends OverviewState {
  final OverviewData data;
  final Timeframe timeframe;
  final DateTime? startDate;
  final DateTime? endDate;

  const OverviewLoaded(
    this.data, {
    this.timeframe = Timeframe.last7Days,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [data, timeframe, startDate, endDate];
}

class OverviewError extends OverviewState {
  final String message;

  const OverviewError(this.message);

  @override
  List<Object?> get props => [message];
}
