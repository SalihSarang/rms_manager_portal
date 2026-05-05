import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:manager_portal/features/settings/presentation/widgets/business_profile/business_profile_form.dart';
import 'package:manager_portal/features/settings/presentation/widgets/business_profile/save_business_details_button.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

class BusinessProfileScreen extends StatelessWidget {
  BusinessProfileScreen({super.key});

  final _nameController = TextEditingController(text: 'My Restaurant');
  final _addressController = TextEditingController(
    text: '123 Food Street, Bangalore, Karnataka',
  );
  final _phoneController = TextEditingController(text: '+91 9876543210');
  final _emailController = TextEditingController(text: 'info@myrestaurant.com');
  final _fssaiController = TextEditingController(text: '12345678901234');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: const RmsDetailAppBar(title: 'Business Profile'),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                BusinessProfileForm(
                  nameController: _nameController,
                  addressController: _addressController,
                  phoneController: _phoneController,
                  emailController: _emailController,
                  fssaiController: _fssaiController,
                ),
                const SizedBox(height: 40),
                SaveBusinessDetailsButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
