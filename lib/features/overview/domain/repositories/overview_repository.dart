import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';

abstract class OverviewRepository {
  Future<OverviewData> getOverviewData(Timeframe timeframe, {DateTime? startDate, DateTime? endDate});
}
