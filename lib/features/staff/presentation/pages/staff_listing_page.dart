import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff/presentation/utils/sidebar_utils.dart';
import 'package:manager_portal/features/staff/presentation/widgets/activity_container/activity_container.dart';
import 'package:manager_portal/features/staff/presentation/widgets/appbar/appbar.dart';
import 'package:manager_portal/features/staff/presentation/widgets/search_bar_container/search_bar_container.dart';
import 'package:manager_portal/features/staff/presentation/widgets/staff_list_container/staff_list_container.dart';

class StaffListingScreen extends StatelessWidget {
  const StaffListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaffManagementAppbar(
        onAddPressed: () {
          showAddStaffSidebar(context);
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const SearchBarContainer(),
                          const SizedBox(height: 20),
                          const StaffListContainer(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(flex: 1, child: ActivityContainer()),
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SearchBarContainer(),
                    const SizedBox(height: 20),
                    const StaffListContainer(),
                    const SizedBox(height: 20),
                    const ActivityContainer(),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
