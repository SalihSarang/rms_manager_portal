import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'staff_profile_sidebar.dart';
import 'staff_recent_shifts_table.dart';
import 'staff_daily_earnings_table.dart';
import 'staff_documents_section.dart';

class StaffDetailsBody extends StatelessWidget {
  final StaffModel staff;

  const StaffDetailsBody({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Profile Sidebar
          StaffProfileSidebar(staff: staff),
          const SizedBox(width: 24),
          // Right: Content Area
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: TextColors.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Recent Shifts Table
                  StaffRecentShiftsTable(staff: staff),
                  const SizedBox(height: 24),
                  // Daily Earnings Table
                  StaffDailyEarningsTable(staff: staff),
                  const SizedBox(height: 24),
                  // ID & Documents Section
                  StaffDocumentsSection(staff: staff),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
