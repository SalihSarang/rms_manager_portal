import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class GstConfigurationForm extends StatelessWidget {
  final TextEditingController gstinController;
  final TextEditingController cgstController;
  final TextEditingController sgstController;

  const GstConfigurationForm({
    super.key,
    required this.gstinController,
    required this.cgstController,
    required this.sgstController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GST Configuration',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        PrimaryTextField(
          controller: gstinController,
          label: 'GSTIN',
          hintText: 'Enter 15-digit GSTIN',
          prefixIcon: Icons.receipt_long_outlined,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: PrimaryTextField(
                controller: cgstController,
                label: 'CGST (%)',
                hintText: '2.5',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PrimaryTextField(
                controller: sgstController,
                label: 'SGST (%)',
                hintText: '2.5',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Total GST: 5.0%',
          style: TextStyle(
            color: TextColors.secondary,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
