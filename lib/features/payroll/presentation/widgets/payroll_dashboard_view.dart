import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payout_confirmation_dialog.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_state.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_filters.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_card.dart';

class PayrollDashboardView extends StatelessWidget {
  const PayrollDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    // Expanded Mock Data with different wage types and statuses
    final List<StaffModel> mockStaffList = [
      StaffModel(
        id: '1',
        name: 'Sarah Jenkins',
        email: 'sarah@bistro.com',
        phoneNumber: '1234567890',
        role: UserRole.waiter,
        avatar: '',
        idProof: '',
        isActive: true,
        baseWage: 500,
        wageType: WageType.hourly,
      ),
      StaffModel(
        id: '2',
        name: 'Michael Scott',
        email: 'michael@bistro.com',
        phoneNumber: '0987654321',
        role: UserRole.waiter,
        avatar: '',
        idProof: '',
        isActive: true,
        baseWage: 450,
        wageType: WageType.hourly,
      ),
      StaffModel(
        id: '3',
        name: 'Pam Beesly',
        email: 'pam@bistro.com',
        phoneNumber: '1122334455',
        role: UserRole.cashier,
        avatar: '',
        idProof: '',
        isActive: true,
        baseWage: 25000,
        wageType: WageType.monthly,
      ),
    ];

    final Map<String, SalaryCalculationResult> mockResults = {
      '1': SalaryCalculationResult(
        totalDue: 4000.0,
        totalMinutesWorked: 480, // 8 hours
        processedShifts: [],
      ),
      '2': SalaryCalculationResult(
        totalDue: 0.0, // Simulates a completed payment (no pending dues)
        totalMinutesWorked: 0,
        processedShifts: [],
      ),
      '3': SalaryCalculationResult(
        totalDue: 25000.0, // Monthly salary due
        totalMinutesWorked: 9600, // 160 hours
        processedShifts: [],
      ),
    };

    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: const RmsDetailAppBar(title: 'Payroll Dashboard'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payroll Management',
              style: TextStyle(
                color: TextColors.primary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Review outstanding wages based on completed shifts and process payouts.',
              style: TextStyle(color: TextColors.secondary, fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            // Filter Section
            const PayrollFilters(),
            
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<PayrollDashboardCubit, PayrollDashboardState>(
                builder: (context, state) {
                  // Apply filters
                  final filteredStaff = mockStaffList.where((staff) {
                    final result = mockResults[staff.id]!;
                    
                    // Wage Type Filter
                    if (state.selectedWageType != null && staff.wageType != state.selectedWageType) {
                      return false;
                    }

                    // Status Filter
                    if (state.selectedStatus == 'Pending' && result.totalDue <= 0) {
                      return false;
                    }
                    if (state.selectedStatus == 'Completed' && result.totalDue > 0) {
                      return false;
                    }

                    return true;
                  }).toList();

                  if (filteredStaff.isEmpty) {
                    return const Center(
                      child: Text('No staff match the selected filters.',
                          style: TextStyle(color: TextColors.secondary)),
                    );
                  }

                  return ListView.separated(
                    itemCount: filteredStaff.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final staff = filteredStaff[index];
                      final result = mockResults[staff.id]!;
                      return PayrollCard(
                        staff: staff,
                        result: result,
                        onPayTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => PayoutConfirmationDialog(
                              staff: staff,
                              calculationResult: result,
                              onConfirm: (amount) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Processing ₹$amount for ${staff.name} via RazorpayX...'),
                                    backgroundColor: PrimaryColors.defaultColor,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
