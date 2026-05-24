import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/staff_validators.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_fields.dart';

class StaffInfoFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const StaffInfoFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledTextField(
          label: 'Full Name',
          hint: 'e.g. Sarah Jenkins',
          controller: nameController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(FullNameChanged(value)),
          validator: StaffValidators.validateFullName,
        ),
        const SizedBox(height: 20),
        LabeledTextField(
          label: 'Email Address',
          hint: 'e.g. sarah.j@bistro.com',
          keyboardType: TextInputType.emailAddress,
          controller: emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(EmailChanged(value)),
          validator: StaffValidators.validateEmail,
        ),
        const SizedBox(height: 20),
        LabeledTextField(
          label: 'Phone Number',
          hint: "Enter Staff's Phone Number",
          keyboardType: TextInputType.phone,
          controller: phoneController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(PhoneNumberChanged(value)),
          validator: StaffValidators.validatePhoneNumber,
        ),
      ],
    );
  }
}
