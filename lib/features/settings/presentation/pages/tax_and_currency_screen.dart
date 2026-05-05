import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/features/settings/presentation/widgets/tax_and_currency/currency_info_card.dart';
import 'package:manager_portal/features/settings/presentation/widgets/tax_and_currency/gst_configuration_form.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

class TaxAndCurrencyScreen extends StatelessWidget {
  TaxAndCurrencyScreen({super.key});

  final _gstinController = TextEditingController();
  final _cgstController = TextEditingController();
  final _sgstController = TextEditingController();

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
                const CurrencyInfoCard(),
                const SizedBox(height: 32),
                GstConfigurationForm(
                  gstinController: _gstinController,
                  cgstController: _cgstController,
                  sgstController: _sgstController,
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
