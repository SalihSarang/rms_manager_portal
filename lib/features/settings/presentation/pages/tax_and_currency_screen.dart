import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class TaxAndCurrencyScreen extends StatefulWidget {
  const TaxAndCurrencyScreen({super.key});

  @override
  State<TaxAndCurrencyScreen> createState() => _TaxAndCurrencyScreenState();
}

class _TaxAndCurrencyScreenState extends State<TaxAndCurrencyScreen> {
  final _gstinController = TextEditingController(text: '29AAAAA0000A1Z5');
  final _cgstController = TextEditingController(text: '2.5');
  final _sgstController = TextEditingController(text: '2.5');

  @override
  void dispose() {
    _gstinController.dispose();
    _cgstController.dispose();
    _sgstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: const RmsDetailAppBar(title: 'Tax & Currency'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Currency',
                  style: TextStyle(
                    color: TextColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: NeutralColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: NeutralColors.border),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.payments_outlined, color: PrimaryColors.defaultColor),
                      SizedBox(width: 12),
                      Text(
                        'Indian Rupee (INR - ₹)',
                        style: TextStyle(color: TextColors.primary, fontSize: 16),
                      ),
                      Spacer(),
                      Icon(Icons.check_circle, color: PrimaryColors.defaultColor),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
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
                  controller: _gstinController,
                  label: 'GSTIN',
                  hintText: 'Enter 15-digit GSTIN',
                  prefixIcon: Icons.receipt_long_outlined,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryTextField(
                        controller: _cgstController,
                        label: 'CGST (%)',
                        hintText: '2.5',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PrimaryTextField(
                        controller: _sgstController,
                        label: 'SGST (%)',
                        hintText: '2.5',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement save logic
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PrimaryColors.defaultColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save Tax Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
