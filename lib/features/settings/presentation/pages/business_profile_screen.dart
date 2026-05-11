import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/core/widgets/buttons/primary_elevated_button.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:manager_portal/features/settings/presentation/cubit/settings_state.dart';
import 'package:manager_portal/features/settings/presentation/widgets/business_profile/business_profile_form.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_shared_package/rms_shared_package.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _fssaiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<SettingsCubit>().state;
    if (state is SettingsLoaded) {
      _populateControllers(state.settings);
    }
  }

  void _populateControllers(RestaurantModel settings) {
    _nameController.text = settings.name;
    _addressController.text = settings.address;
    _phoneController.text = settings.phone;
    _emailController.text = settings.email;
    _fssaiController.text = settings.fssaiNumber;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          if (_nameController.text.isEmpty && state.settings.name.isNotEmpty) {
            _populateControllers(state.settings);
          }
        }

        if (state is SettingsUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Business Profile Updated')),
          );
          Navigator.pop(context);
        } else if (state is SettingsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: const RmsDetailAppBar(title: 'Business Profile'),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      BusinessProfileForm(
                        nameController: _nameController,
                        addressController: _addressController,
                        phoneController: _phoneController,
                        emailController: _emailController,
                        fssaiController: _fssaiController,
                      ),
                      const SizedBox(height: 40),
                      PrimaryElevatedButton(
                        label: 'Save Business Details',
                        isLoading: state is SettingsLoading,
                        onPressed: state is SettingsLoaded
                            ? () {
                                final updatedSettings = state.settings.copyWith(
                                  name: _nameController.text,
                                  address: _addressController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text,
                                  fssaiNumber: _fssaiController.text,
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
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _fssaiController.dispose();
    super.dispose();
  }
}
