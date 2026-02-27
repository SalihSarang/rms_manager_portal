import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/responsive_layout.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/activity_container/activity_container.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/search_bar_container/search_bar_container.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_list_container/staff_list_container.dart';

class ResponsiveStaffLayout extends StatelessWidget {
  const ResponsiveStaffLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      mobile: StaffSmallScreenLayout(),
      desktop: StaffLargeScreenLayout(
        padding: EdgeInsets.symmetric(horizontal: 90),
      ),
    );
  }
}

class StaffLargeScreenLayout extends StatelessWidget {
  final EdgeInsetsGeometry padding;

  const StaffLargeScreenLayout({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 90),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: const [
                SearchBarContainer(),
                SizedBox(height: 20),
                StaffListContainer(),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(flex: 1, child: ActivityContainer()),
        ],
      ),
    );
  }
}

class StaffSmallScreenLayout extends StatelessWidget {
  const StaffSmallScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          SearchBarContainer(),
          SizedBox(height: 20),
          Expanded(child: StaffListContainer()),
          SizedBox(height: 20),
          ActivityContainer(),
        ],
      ),
    );
  }
}
