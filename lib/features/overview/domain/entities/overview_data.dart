import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

class OverviewData extends Equatable {
  final SummaryStats summaryStats;
  final List<RevenuePoint> revenueTrend;
  final List<OrderVolumePoint> orderVolume;
  final List<LeaderboardEntry> waitStaffLeaderboard;
  final List<BestSellerEntry> bestSellingItems;

  const OverviewData({
    required this.summaryStats,
    required this.revenueTrend,
    required this.orderVolume,
    required this.waitStaffLeaderboard,
    required this.bestSellingItems,
  });

  @override
  List<Object?> get props => [
        summaryStats,
        revenueTrend,
        orderVolume,
        waitStaffLeaderboard,
        bestSellingItems,
      ];
}

class SummaryStats extends Equatable {
  final double totalRevenue;
  final int totalOrders;
  final int activeChefs;
  final int totalChefs;
  final int activeWaiters;
  final int totalWaiters;

  const SummaryStats({
    required this.totalRevenue,
    required this.totalOrders,
    required this.activeChefs,
    required this.totalChefs,
    required this.activeWaiters,
    required this.totalWaiters,
  });

  @override
  List<Object?> get props => [
        totalRevenue,
        totalOrders,
        activeChefs,
        totalChefs,
        activeWaiters,
        totalWaiters,
      ];
}

class RevenuePoint extends Equatable {
  final String day;
  final double amount;

  const RevenuePoint({required this.day, required this.amount});

  @override
  List<Object?> get props => [day, amount];
}

class OrderVolumePoint extends Equatable {
  final String hour;
  final int orders;

  const OrderVolumePoint({required this.hour, required this.orders});

  @override
  List<Object?> get props => [hour, orders];
}

class LeaderboardEntry extends Equatable {
  final StaffModel staff;
  final double revenue;
  final int ordersCount;

  const LeaderboardEntry({
    required this.staff,
    required this.revenue,
    required this.ordersCount,
  });

  @override
  List<Object?> get props => [staff, revenue, ordersCount];
}

class BestSellerEntry extends Equatable {
  final FoodModel food;
  final int quantitySold;
  final double revenue;

  const BestSellerEntry({
    required this.food,
    required this.quantitySold,
    required this.revenue,
  });

  @override
  List<Object?> get props => [food, quantitySold, revenue];
}
