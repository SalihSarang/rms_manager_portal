import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffBankDetailsFields extends StatelessWidget {
  final TextEditingController bankNameController;
  final TextEditingController accountNumberController;
  final TextEditingController ifscCodeController;
  final TextEditingController upiIdController;

  const StaffBankDetailsFields({
    super.key,
    required this.bankNameController,
    required this.accountNumberController,
    required this.ifscCodeController,
    required this.upiIdController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bank Details',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: bankNameController,
          label: 'Bank Name',
          hint: 'e.g. HDFC Bank',
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(BankNameChanged(value)),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: accountNumberController,
          label: 'Account Number',
          hint: 'Enter account number',
          keyboardType: TextInputType.number,
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(AccountNumberChanged(value)),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: ifscCodeController,
          label: 'IFSC Code',
          hint: 'e.g. HDFC0001234',
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(IfscCodeChanged(value.toUpperCase())),
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: upiIdController,
          label: 'UPI ID',
          hint: 'e.g. name@upi',
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(UpiIdChanged(value)),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: TextColors.secondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: const TextStyle(color: TextColors.primary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: TextColors.secondary.withValues(alpha: 0.5)),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF303030)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF303030)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
