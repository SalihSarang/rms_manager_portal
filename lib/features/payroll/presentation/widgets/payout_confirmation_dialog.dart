import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/status_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/features/payroll/domain/usecases/calculate_salary_usecase.dart';

class PayoutConfirmationDialog extends StatefulWidget {
  final StaffModel staff;
  final SalaryCalculationResult calculationResult;
  final Function(double finalAmount) onConfirm;

  const PayoutConfirmationDialog({
    super.key,
    required this.staff,
    required this.calculationResult,
    required this.onConfirm,
  });

  @override
  State<PayoutConfirmationDialog> createState() =>
      _PayoutConfirmationDialogState();
}

class _PayoutConfirmationDialogState extends State<PayoutConfirmationDialog> {
  late TextEditingController _bonusController;
  late TextEditingController _deductionController;
  double _finalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _bonusController = TextEditingController(text: '0');
    _deductionController = TextEditingController(text: '0');
    _calculateFinalAmount();
  }

  @override
  void dispose() {
    _bonusController.dispose();
    _deductionController.dispose();
    super.dispose();
  }

  void _calculateFinalAmount() {
    final double baseAmount = widget.calculationResult.totalDue;
    final double bonus = double.tryParse(_bonusController.text) ?? 0.0;
    final double deduction = double.tryParse(_deductionController.text) ?? 0.0;
    setState(() {
      _finalAmount = baseAmount + bonus - deduction;
      if (_finalAmount < 0) _finalAmount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: NeutralColors.surface,
      child: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBreakdownTiles(),
                  const SizedBox(height: 24),
                  _buildAdjustments(),
                  const SizedBox(height: 24),
                  const Divider(color: NeutralColors.border, height: 1),
                  const SizedBox(height: 20),
                  _buildTotalRow(),
                  const SizedBox(height: 24),
                  _buildCtaButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section 1: Flat Header ──────────────────────────────────────────────────

  Widget _buildHeader() {
    final String roleLabel = _getRoleLabel(widget.staff.role);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              const Icon(
                Icons.account_balance_wallet_outlined,
                color: PrimaryColors.defaultColor,
                size: 22,
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                radius: 18,
                backgroundColor: StatusColors.preparingBg,
                child: Text(
                  widget.staff.name.isNotEmpty ? widget.staff.name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: StatusColors.preparingText,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.staff.name,
                  style: const TextStyle(
                    color: TextColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: NeutralColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: NeutralColors.border),
                ),
                child: Text(
                  roleLabel,
                  style: const TextStyle(
                    color: TextColors.secondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => Navigator.pop(context),
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, color: TextColors.secondary, size: 20),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: NeutralColors.border, height: 1),
      ],
    );
  }

  // ── Section 2: Breakdown Stat Tiles ────────────────────────────────────────

  Widget _buildBreakdownTiles() {
    final String hoursWorked =
        '${(widget.calculationResult.totalMinutesWorked / 60).toStringAsFixed(1)} hrs';
    final String baseEarned =
        '₹${widget.calculationResult.totalDue.toStringAsFixed(2)}';
    final String shifts =
        '${widget.calculationResult.processedShifts.length}';

    return Row(
      children: [
        Expanded(
          child: _buildStatTile(
            icon: Icons.currency_rupee_rounded,
            label: 'Base Earned',
            value: baseEarned,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatTile(
            icon: Icons.schedule_outlined,
            label: 'Hours',
            value: hoursWorked,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatTile(
            icon: Icons.calendar_today_outlined,
            label: 'Shifts',
            value: shifts,
          ),
        ),
      ],
    );
  }

  Widget _buildStatTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: NeutralColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: TextColors.secondary, size: 16),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: TextColors.secondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: TextColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ── Section 3: Adjustments ──────────────────────────────────────────────────

  Widget _buildAdjustments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ADJUSTMENTS',
          style: TextStyle(
            color: TextColors.secondary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildAdjustmentField(isBonus: true)),
            const SizedBox(width: 12),
            Expanded(child: _buildAdjustmentField(isBonus: false)),
          ],
        ),
      ],
    );
  }

  Widget _buildAdjustmentField({required bool isBonus}) {
    final Color tintColor =
        isBonus ? StatusColors.ready : StatusColors.cancelled;
    final IconData icon =
        isBonus ? Icons.add_circle_outline : Icons.remove_circle_outline;
    final String label = isBonus ? 'Bonus (₹)' : 'Deduction (₹)';
    final controller = isBonus ? _bonusController : _deductionController;

    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (_) => _calculateFinalAmount(),
      style: const TextStyle(color: TextColors.primary, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: tintColor.withValues(alpha: 0.8), fontSize: 13),
        filled: true,
        fillColor: tintColor.withValues(alpha: 0.07),
        prefixIcon: Icon(icon, color: tintColor, size: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: tintColor.withValues(alpha: 0.35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: tintColor, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  // ── Section 4: Total Row ────────────────────────────────────────────────────

  Widget _buildTotalRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Payout',
          style: TextStyle(
            color: TextColors.secondary,
            fontSize: 15,
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Text(
            '₹${_finalAmount.toStringAsFixed(2)}',
            key: ValueKey(_finalAmount),
            style: const TextStyle(
              color: StatusColors.ready,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ── Section 5: CTA Button ───────────────────────────────────────────────────

  Widget _buildCtaButton() {
    final bool enabled = _finalAmount > 0;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: enabled
            ? () {
                widget.onConfirm(_finalAmount);
                Navigator.pop(context);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: PrimaryColors.defaultColor,
          disabledBackgroundColor: NeutralColors.border,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        icon: Icon(
          Icons.lock_outline_rounded,
          color: enabled ? Colors.white : TextColors.muted,
          size: 18,
        ),
        label: Text(
          'Process via RazorpayX',
          style: TextStyle(
            color: enabled ? Colors.white : TextColors.muted,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────────────────────────

  String _getRoleLabel(UserRole? role) {
    if (role == null) return 'Staff';
    switch (role) {
      case UserRole.waiter:
        return 'Waiter';
      case UserRole.billing:
        return 'Billing';
      case UserRole.chef:
        return 'Chef';
      case UserRole.cashier:
        return 'Cashier';
      case UserRole.kitchen:
        return 'Kitchen';
    }
  }
}
