import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/manual_payout_cubit.dart';
import 'widgets/payout_account_details.dart';
import 'widgets/payout_action_buttons.dart';
import 'widgets/payout_adjustments_section.dart';
import 'widgets/payout_dialog_header.dart';
import 'widgets/payout_method_selector.dart';
import 'widgets/payout_staff_summary.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class ManualPayoutDialog extends StatelessWidget {
  final StaffModel staff;
  final double amount;
  final Function(PaymentMethod method, String notes, double finalAmount)
  onConfirm;

  const ManualPayoutDialog({
    super.key,
    required this.staff,
    required this.amount,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManualPayoutCubit(amount),
      child: BlocBuilder<ManualPayoutCubit, ManualPayoutState>(
        builder: (context, state) {
          final cubit = context.read<ManualPayoutCubit>();

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: NeutralColors.surface.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: NeutralColors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 40,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PayoutDialogHeader(
                          title: 'Manual Payout',
                          subtitle: 'Confirm and record payment',
                        ),
                        const SizedBox(height: 32),
                        PayoutStaffSummary(
                          staff: staff,
                          baseAmount: amount,
                          incentive: state.incentive,
                          deduction: state.deduction,
                        ),
                        const SizedBox(height: 32),
                        PayoutAdjustmentsSection(
                          onIncentiveChanged: cubit.updateIncentive,
                          onDeductionChanged: cubit.updateDeduction,
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'PAYMENT METHOD',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: TextColors.secondary,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        PayoutMethodSelector(
                          selectedMethod: state.selectedMethod,
                          onMethodChanged: cubit.updateMethod,
                        ),
                        const SizedBox(height: 24),
                        if (state.selectedMethod != PaymentMethod.cash)
                          PayoutAccountDetails(
                            staff: staff,
                            selectedMethod: state.selectedMethod,
                          ),
                        const SizedBox(height: 40),
                        PayoutActionButtons(
                          onCancel: () => Navigator.pop(context),
                          onConfirm: () {
                            final String notes =
                                'Adjustments: Incentive=${state.incentive}, Deduction=${state.deduction}';
                            onConfirm(
                              state.selectedMethod,
                              notes,
                              state.finalAmount,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
