import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';
import 'package:manager_portal/features/overview/domain/repositories/overview_repository.dart';
import 'package:manager_portal/features/overview/data/datasources/overview_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/data/datasources/food_remote_datasource.dart';
import 'package:manager_portal/features/staff_management/data/datasources/staff_datasource.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rxdart/rxdart.dart';

class OverviewRepositoryImpl implements OverviewRepository {
  final OverviewRemoteDataSource remoteDataSource;
  final IFoodRemoteDataSource foodRemoteDataSource;
  final IStaffRemoteDataSource staffRemoteDataSource;

  OverviewRepositoryImpl({
    required this.remoteDataSource,
    required this.foodRemoteDataSource,
    required this.staffRemoteDataSource,
  });

  @override
  Future<OverviewData> getOverviewData(
    Timeframe timeframe, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final rawOrders = await remoteDataSource.getAllOrders();
    final allStaff = await staffRemoteDataSource.getAllStaffs();
    final allFoods = await foodRemoteDataSource.getAllFoodItems();

    return _calculateOverviewData(
      rawOrders: rawOrders,
      allStaff: allStaff,
      allFoods: allFoods,
      timeframe: timeframe,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Stream<OverviewData> watchOverviewData(
    Timeframe timeframe, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CombineLatestStream.combine3(
      remoteDataSource.watchAllOrders(),
      staffRemoteDataSource.watchAllStaffs(),
      foodRemoteDataSource.watchAllFoodItems(),
      (List<OrderModel> orders, List<StaffModel> staff, List<FoodModel> foods) {
        return _calculateOverviewData(
          rawOrders: orders,
          allStaff: staff,
          allFoods: foods,
          timeframe: timeframe,
          startDate: startDate,
          endDate: endDate,
        );
      },
    );
  }

  OverviewData _calculateOverviewData({
    required List<OrderModel> rawOrders,
    required List<StaffModel?> allStaff,
    required List<FoodModel> allFoods,
    required Timeframe timeframe,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final now = DateTime.now();

    // Filter orders by timeframe
    final orders = rawOrders.where((o) {
      final date = o.createdAt;
      switch (timeframe) {
        case Timeframe.today:
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        case Timeframe.yesterday:
          final yesterday = now.subtract(const Duration(days: 1));
          return date.year == yesterday.year &&
              date.month == yesterday.month &&
              date.day == yesterday.day;
        case Timeframe.last7Days:
          final start = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(const Duration(days: 6));
          return date.isAfter(start) ||
              (date.year == start.year &&
                  date.month == start.month &&
                  date.day == start.day);
        case Timeframe.last30Days:
          final start = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(const Duration(days: 29));
          return date.isAfter(start) ||
              (date.year == start.year &&
                  date.month == start.month &&
                  date.day == start.day);
        case Timeframe.custom:
          if (startDate != null && endDate != null) {
            return date.isAfter(
                  startDate.subtract(const Duration(seconds: 1)),
                ) &&
                date.isBefore(endDate.add(const Duration(seconds: 1)));
          }
          return true;
      }
    }).toList();

    // 1. Summary Stats
    double totalRevenue = 0.0;
    int totalOrders = orders.length;
    int activeChefs = 0;
    int totalChefs = 0;
    int activeWaiters = 0;
    int totalWaiters = 0;

    for (final order in orders) {
      if (order.paymentStatus == PaymentStatus.paid) {
        totalRevenue += order.totalAmount;
      }
    }

    for (final staff in allStaff) {
      if (staff == null) continue;
      if (staff.role == UserRole.chef) {
        totalChefs++;
        if (staff.shiftStatus == ShiftStatus.active) activeChefs++;
      } else if (staff.role == UserRole.waiter) {
        totalWaiters++;
        if (staff.shiftStatus == ShiftStatus.active) activeWaiters++;
      }
    }

    final summaryStats = SummaryStats(
      totalRevenue: totalRevenue,
      totalOrders: totalOrders,
      activeChefs: activeChefs,
      totalChefs: totalChefs,
      activeWaiters: activeWaiters,
      totalWaiters: totalWaiters,
    );

    // Define standard hourly buckets for charts (10 AM to 11 PM)
    final hourlyBuckets = [
      '10am', '11am', '12pm', '1pm', '2pm', '3pm', 
      '4pm', '5pm', '6pm', '7pm', '8pm', '9pm', '10pm', '11pm'
    ];

    // 2. Revenue Trend
    final revenueTrend = <RevenuePoint>[];

    if (timeframe == Timeframe.today ||
        timeframe == Timeframe.yesterday ||
        (timeframe == Timeframe.custom &&
            startDate != null &&
            endDate != null &&
            endDate.difference(startDate).inDays <= 2)) {
      
      for (final bucket in hourlyBuckets) {
        final amount = orders
            .where(
              (o) =>
                  o.paymentStatus == PaymentStatus.paid &&
                  _isOrderInBucket(o, bucket),
            )
            .fold(0.0, (sum, o) => sum + o.totalAmount);
        revenueTrend.add(RevenuePoint(day: bucket, amount: amount));
      }
    } else {
      final daysCount = timeframe == Timeframe.last7Days
          ? 7
          : timeframe == Timeframe.last30Days
          ? 30
          : (startDate != null && endDate != null
                ? endDate.difference(startDate).inDays + 1
                : 7);
      final weekdays = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

      for (var i = daysCount - 1; i >= 0; i--) {
        final day = timeframe == Timeframe.custom && endDate != null
            ? endDate.subtract(Duration(days: i))
            : now.subtract(Duration(days: i));

        final dayStr = daysCount <= 7 ? weekdays[day.weekday] : '${day.day}';

        final amount = orders
            .where(
              (o) =>
                  o.paymentStatus == PaymentStatus.paid &&
                  o.createdAt.year == day.year &&
                  o.createdAt.month == day.month &&
                  o.createdAt.day == day.day,
            )
            .fold(0.0, (sum, o) => sum + o.totalAmount);

        revenueTrend.add(RevenuePoint(day: dayStr, amount: amount));
      }
    }

    // 3. Order Volume (Hourly Buckets)
    final orderVolume = <OrderVolumePoint>[];

    for (final bucket in hourlyBuckets) {
      final count = orders.where((o) => _isOrderInBucket(o, bucket)).length;
      orderVolume.add(OrderVolumePoint(hour: bucket, orders: count));
    }

    // 4. Waitstaff Leaderboard
    final waiterStats = <String, _StaffStat>{};
    for (final order in orders) {
      if (order.staffId.isNotEmpty) {
        final stat = waiterStats.putIfAbsent(order.staffId, () => _StaffStat());
        stat.revenue += order.totalAmount;
        stat.ordersCount += 1;
      }
    }

    final waitStaffLeaderboard = <LeaderboardEntry>[];
    for (final staff in allStaff) {
      if (staff != null && staff.role == UserRole.waiter) {
        final stat = waiterStats[staff.id];
        waitStaffLeaderboard.add(
          LeaderboardEntry(
            staff: staff,
            revenue: stat?.revenue ?? 0.0,
            ordersCount: stat?.ordersCount ?? 0,
          ),
        );
      }
    }
    waitStaffLeaderboard.sort((a, b) => b.revenue.compareTo(a.revenue));

    // 5. Best Selling Items
    final foodStats = <String, _FoodStat>{};
    for (final order in orders) {
      for (final item in order.orderedMenu) {
        final stat = foodStats.putIfAbsent(item.foodId, () => _FoodStat());
        stat.quantitySold += item.quantity;
        stat.revenue += item.quantity * item.price;
      }
    }

    final bestSellingItems = <BestSellerEntry>[];
    for (final food in allFoods) {
      final stat = foodStats[food.id];
      if (stat != null) {
        bestSellingItems.add(
          BestSellerEntry(
            food: food,
            quantitySold: stat.quantitySold,
            revenue: stat.revenue,
          ),
        );
      }
    }
    bestSellingItems.sort((a, b) => b.quantitySold.compareTo(a.quantitySold));

    return OverviewData(
      summaryStats: summaryStats,
      revenueTrend: revenueTrend,
      orderVolume: orderVolume,
      waitStaffLeaderboard: waitStaffLeaderboard,
      bestSellingItems: bestSellingItems,
    );
  }

  bool _isOrderInBucket(OrderModel o, String bucket) {
    final hour = o.createdAt.hour;
    final bucketHour = _parseBucketHour(bucket);
    return hour == bucketHour;
  }

  int _parseBucketHour(String bucket) {
    switch (bucket) {
      case '9am': return 9;
      case '10am': return 10;
      case '11am': return 11;
      case '12pm': return 12;
      case '1pm': return 13;
      case '2pm': return 14;
      case '3pm': return 15;
      case '4pm': return 16;
      case '5pm': return 17;
      case '6pm': return 18;
      case '7pm': return 19;
      case '8pm': return 20;
      case '9pm': return 21;
      case '10pm': return 22;
      case '11pm': return 23;
      default: return 0;
    }
  }
}

class _StaffStat {
  double revenue = 0.0;
  int ordersCount = 0;
}

class _FoodStat {
  int quantitySold = 0;
  double revenue = 0.0;
}
