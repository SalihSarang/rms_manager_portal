import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/payroll/presentation/bloc/payroll_dashboard/payroll_dashboard_cubit.dart';
import 'package:manager_portal/features/payroll/presentation/widgets/payroll_dashboard_view.dart';

class PayrollDashboardPage extends StatelessWidget {
  const PayrollDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PayrollDashboardCubit(),
      child: const PayrollDashboardView(),
    );
  }
}
