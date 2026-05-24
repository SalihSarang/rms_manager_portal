import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';

class BusinessProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController fssaiController;

  const BusinessProfileForm({
    super.key,
    required this.nameController,
    required this.addressController,
    required this.phoneController,
    required this.emailController,
    required this.fssaiController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          controller: nameController,
          label: 'Restaurant Name',
          hintText: 'Enter restaurant name',
          prefixIcon: Icons.restaurant_outlined,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: addressController,
          label: 'Full Address',
          hintText: 'Enter restaurant address',
          prefixIcon: Icons.location_on_outlined,
          maxLines: 3,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: phoneController,
          label: 'Phone Number',
          hintText: 'Enter phone number',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: emailController,
          label: 'Business Email',
          hintText: 'Enter business email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: fssaiController,
          label: 'FSSAI License Number',
          hintText: 'Enter 14-digit FSSAI number',
          prefixIcon: Icons.verified_user_outlined,
        ),
      ],
    );
  }
}
