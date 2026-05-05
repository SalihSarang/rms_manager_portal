import 'package:flutter/material.dart';
import 'package:manager_portal/core/widgets/inputs/primary_text_field.dart';

class EditProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;

  const EditProfileForm({
    super.key,
    required this.nameController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          controller: nameController,
          label: 'Full Name',
          hintText: 'Enter your name',
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 20),
        PrimaryTextField(
          controller: emailController,
          label: 'Email Address',
          hintText: 'Enter your email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
