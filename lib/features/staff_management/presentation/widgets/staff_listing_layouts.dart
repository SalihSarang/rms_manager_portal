import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/activity_container/activity_container.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/search_bar_container/search_bar_container.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_list_container/staff_list_container.dart';

class StaffLargeScreenLayout extends StatelessWidget {
  const StaffLargeScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class StaffSmallScreenLayout extends StatelessWidget {
  const StaffSmallScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchBarContainer(),
        SizedBox(height: 20),
        StaffListContainer(),
        SizedBox(height: 20),
        ActivityContainer(),
      ],
    );
  }
}
