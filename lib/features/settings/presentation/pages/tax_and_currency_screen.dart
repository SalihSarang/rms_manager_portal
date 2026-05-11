import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/core/widgets/buttons/primary_elevated_button.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_state.dart';
import 'package:manager_portal/features/settings/presentation/widgets/tax_and_currency/currency_info_card.dart';
import 'package:manager_portal/features/settings/presentation/widgets/tax_and_currency/gst_configuration_form.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class TaxAndCurrencyScreen extends StatefulWidget {
  const TaxAndCurrencyScreen({super.key});

  @override
  State<TaxAndCurrencyScreen> createState() => _TaxAndCurrencyScreenState();
}

class _TaxAndCurrencyScreenState extends State<TaxAndCurrencyScreen> {
  final _gstinController = TextEditingController();
  final _cgstController = TextEditingController();
  final _sgstController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsCubit>().state;
    if (state is SettingsLoaded) {
      _populateControllers(state.settings);
    }
  }

  void _populateControllers(RestaurantModel settings) {
    _gstinController.text = settings.gstin;
    _cgstController.text = settings.cgstRate.toString();
    _sgstController.text = settings.sgstRate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          if (_gstinController.text.isEmpty &&
              state.settings.gstin.isNotEmpty) {
            _populateControllers(state.settings);
          }
        }

        if (state is SettingsUpdateSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Tax Settings Updated')));
          Navigator.pop(context);
        } else if (state is SettingsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: const RmsDetailAppBar(title: 'Tax & Currency'),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Column(
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
                      PrimaryElevatedButton(
                        label: 'Save Tax Settings',
                        isLoading: state is SettingsLoading,
                        onPressed: state is SettingsLoaded
                            ? () {
                                final updatedSettings = state.settings.copyWith(
                                  gstin: _gstinController.text,
                                  cgstRate:
                                      double.tryParse(_cgstController.text) ??
                                      0.0,
                                  sgstRate:
                                      double.tryParse(_sgstController.text) ??
                                      0.0,
                                );

                                context.read<SettingsCubit>().updateSettings(
                                  updatedSettings,
                                );
                              }
                            : null,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _gstinController.dispose();
    _cgstController.dispose();
    _sgstController.dispose();
    super.dispose();
  }
}
