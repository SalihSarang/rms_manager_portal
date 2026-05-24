import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class MockOverviewRepository {
  Future<OverviewData> getOverviewData() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return OverviewData(
      summaryStats: const SummaryStats(
        totalRevenue: 128430.00,
        totalOrders: 3042,
        activeChefs: 18,
        totalChefs: 24,
        activeWaiters: 18,
        totalWaiters: 24,
      ),
      revenueTrend: const [
        RevenuePoint(day: 'Mon', amount: 3000),
        RevenuePoint(day: 'Tue', amount: 4500),
        RevenuePoint(day: 'Wed', amount: 4200),
        RevenuePoint(day: 'Thu', amount: 5800),
        RevenuePoint(day: 'Fri', amount: 5200),
        RevenuePoint(day: 'Sat', amount: 7500),
        RevenuePoint(day: 'Sun', amount: 8200),
      ],
      orderVolume: const [
        OrderVolumePoint(hour: '11am', orders: 120),
        OrderVolumePoint(hour: '1pm', orders: 250),
        OrderVolumePoint(hour: '3pm', orders: 180),
        OrderVolumePoint(hour: '5pm', orders: 420),
        OrderVolumePoint(hour: '7pm', orders: 350),
        OrderVolumePoint(hour: '9pm', orders: 220),
        OrderVolumePoint(hour: '11pm', orders: 100),
      ],
      waitStaffLeaderboard: [
        LeaderboardEntry(
          staff: StaffModel(
            id: '1',
            name: 'Elena Rodriguez',
            email: 'elena@rms.com',
            phoneNumber: '1234567890',
            avatar: 'https://i.pravatar.cc/150?u=1',
            idProof: '',
            role: UserRole.waiter,
            isActive: true,
          ),
          revenue: 1840.50,
          ordersCount: 42,
        ),
        LeaderboardEntry(
          staff: StaffModel(
            id: '2',
            name: 'Marcus Chen',
            email: 'marcus@rms.com',
            phoneNumber: '1234567891',
            avatar: 'https://i.pravatar.cc/150?u=2',
            idProof: '',
            role: UserRole.waiter,
            isActive: true,
          ),
          revenue: 1520.00,
          ordersCount: 38,
        ),
        LeaderboardEntry(
          staff: StaffModel(
            id: '3',
            name: 'Sarah Jenkins',
            email: 'sarah@rms.com',
            phoneNumber: '1234567892',
            avatar: 'https://i.pravatar.cc/150?u=3',
            idProof: '',
            role: UserRole.waiter,
            isActive: true,
          ),
          revenue: 1290.75,
          ordersCount: 31,
        ),
      ],
      bestSellingItems: [
        BestSellerEntry(
          food: FoodModel(
            id: 'f1',
            name: 'Wagyu Beef Burger',
            description: 'Premium wagyu beef',
            imageUrl: '',
            category: CategoryModel.empty(),
            isAvailable: true,
            isFeatured: false,
            isVeg: false,
            isCustomNotes: false,
            portions: [],
            addOns: [],
          ),

          quantitySold: 214,
          revenue: 4708.00,
        ),
        BestSellerEntry(
          food: FoodModel(
            id: 'f2',
            name: 'Grilled Sea Bass',
            description: 'Fresh sea bass',
            imageUrl: '',
            category: CategoryModel.empty(),
            isAvailable: true,
            isFeatured: false,
            isVeg: false,
            isCustomNotes: false,
            portions: [],
            addOns: [],
          ),

          quantitySold: 182,
          revenue: 5460.00,
        ),
        BestSellerEntry(
          food: FoodModel(
            id: 'f3',
            name: 'Truffle Parmesan Fries',
            description: 'Crispy fries with truffle',
            imageUrl: '',
            category: CategoryModel.empty(),
            isAvailable: true,
            isFeatured: false,
            isVeg: true,
            isCustomNotes: false,
            portions: [],
            addOns: [],
          ),

          quantitySold: 156,
          revenue: 1872.00,
        ),
      ],
    );
  }
}
