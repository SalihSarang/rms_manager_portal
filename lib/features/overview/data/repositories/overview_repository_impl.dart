import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';
import 'package:manager_portal/features/overview/domain/repositories/overview_repository.dart';
import 'package:manager_portal/features/overview/data/datasources/overview_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/data/datasources/food_remote_datasource.dart';
import 'package:manager_portal/features/staff_management/data/datasources/staff_datasource.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/order_model/order_model.dart';

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
  Future<OverviewData> getOverviewData(Timeframe timeframe, {DateTime? startDate, DateTime? endDate}) async {
    final rawOrders = await remoteDataSource.getAllOrders();
    final allStaff = await staffRemoteDataSource.getAllStaffs();
    final allFoods = await foodRemoteDataSource.getAllFoodItems();

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
          final start = DateTime(now.year, now.month, now.day)
              .subtract(const Duration(days: 6));
          return date.isAfter(start) ||
              (date.year == start.year &&
                  date.month == start.month &&
                  date.day == start.day);
        case Timeframe.last30Days:
          final start = DateTime(now.year, now.month, now.day)
              .subtract(const Duration(days: 29));
          return date.isAfter(start) ||
              (date.year == start.year &&
                  date.month == start.month &&
                  date.day == start.day);
        case Timeframe.custom:
          if (startDate != null && endDate != null) {
            final start = DateTime(startDate.year, startDate.month, startDate.day);
            final end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
            return date.isAfter(start.subtract(const Duration(seconds: 1))) &&
                date.isBefore(end.add(const Duration(seconds: 1)));
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
        if (staff.isActive) activeChefs++;
      } else if (staff.role == UserRole.waiter) {
        totalWaiters++;
        if (staff.isActive) activeWaiters++;
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

    // 2. Revenue Trend
    final revenueTrend = <RevenuePoint>[];

    if (timeframe == Timeframe.today || 
        timeframe == Timeframe.yesterday || 
        (timeframe == Timeframe.custom && startDate != null && endDate != null && endDate.difference(startDate).inDays <= 2)) {
      final buckets = ['11am', '1pm', '3pm', '5pm', '7pm', '9pm', '11pm'];
      for (final bucket in buckets) {
        final amount = orders
            .where((o) =>
                o.paymentStatus == PaymentStatus.paid &&
                _isOrderInBucket(o, bucket))
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
        final dayStr = daysCount <= 7
            ? weekdays[day.weekday]
            : '${day.day}/${day.month}';

        final amount = orders
            .where((o) =>
                o.paymentStatus == PaymentStatus.paid &&
                o.createdAt.year == day.year &&
                o.createdAt.month == day.month &&
                o.createdAt.day == day.day)
            .fold(0.0, (sum, o) => sum + o.totalAmount);

        revenueTrend.add(RevenuePoint(day: dayStr, amount: amount));
      }
    }

    // 3. Order Volume (Hourly Buckets)
    final orderVolume = <OrderVolumePoint>[];
    final buckets = ['11am', '1pm', '3pm', '5pm', '7pm', '9pm', '11pm'];

    for (final bucket in buckets) {
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
        waitStaffLeaderboard.add(LeaderboardEntry(
          staff: staff,
          revenue: stat?.revenue ?? 0.0,
          ordersCount: stat?.ordersCount ?? 0,
        ));
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
        bestSellingItems.add(BestSellerEntry(
          food: food,
          quantitySold: stat.quantitySold,
          revenue: stat.revenue,
        ));
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
    if (bucket == '11am') return hour >= 10 && hour < 12;
    if (bucket == '1pm') return hour >= 12 && hour < 14;
    if (bucket == '3pm') return hour >= 14 && hour < 16;
    if (bucket == '5pm') return hour >= 16 && hour < 18;
    if (bucket == '7pm') return hour >= 18 && hour < 20;
    if (bucket == '9pm') return hour >= 20 && hour < 22;
    if (bucket == '11pm') return hour >= 22 || hour < 10;
    return false;
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
