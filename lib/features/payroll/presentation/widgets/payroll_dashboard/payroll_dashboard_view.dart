import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'widgets/payroll_filters.dart';
import 'widgets/payroll_header.dart';
import 'payroll_dashboard_body.dart';

class PayrollDashboardView extends StatelessWidget {
  const PayrollDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: RmsDetailAppBar(title: 'Payroll Dashboard'),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PayrollHeader(),

            // Filter Section
            PayrollFilters(),

            SizedBox(height: 24),
            Expanded(child: PayrollDashboardBody()),
          ],
        ),
      ),
    );
  }
}
