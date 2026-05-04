import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';
import 'package:manager_portal/core/widgets/rms_detail_app_bar.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final _nameController = TextEditingController(text: 'My Restaurant');
  final _addressController = TextEditingController(text: '123 Food Street, Bangalore, Karnataka');
  final _phoneController = TextEditingController(text: '+91 9876543210');
  final _emailController = TextEditingController(text: 'info@myrestaurant.com');
  final _fssaiController = TextEditingController(text: '12345678901234');

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _fssaiController.dispose();
    super.dispose();
  }

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
                PrimaryTextField(
                  controller: _nameController,
                  label: 'Restaurant Name',
                  hintText: 'Enter restaurant name',
                  prefixIcon: Icons.restaurant_outlined,
                ),
                const SizedBox(height: 20),
                PrimaryTextField(
                  controller: _addressController,
                  label: 'Full Address',
                  hintText: 'Enter restaurant address',
                  prefixIcon: Icons.location_on_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                PrimaryTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  hintText: 'Enter phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                PrimaryTextField(
                  controller: _emailController,
                  label: 'Business Email',
                  hintText: 'Enter business email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                PrimaryTextField(
                  controller: _fssaiController,
                  label: 'FSSAI License Number',
                  hintText: 'Enter 14-digit FSSAI number',
                  prefixIcon: Icons.verified_user_outlined,
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
                      'Save Business Details',
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
