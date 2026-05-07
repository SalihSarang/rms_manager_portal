import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_form/components/staff_id_proof_upload.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_form/components/staff_info_fields.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_form/components/staff_financial_fields.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_form/components/staff_password_field.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_form/components/staff_role_dropdown.dart';

class AddStaffDialogFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const AddStaffDialogFields({super.key, required this.formKey});

  @override
  State<AddStaffDialogFields> createState() => _AddStaffDialogFieldsState();
}

class _AddStaffDialogFieldsState extends State<AddStaffDialogFields> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _baseWageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _baseWageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _baseWageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddStaffBloc, AddStaffState>(
      listener: (context, state) {
        if (state.mode == AddStaffMode.edit) {
          if (_nameController.text != state.fullName) {
            _nameController.text = state.fullName;
          }
          if (_emailController.text != state.email) {
            _emailController.text = state.email;
          }
          if (_phoneController.text != state.phoneNumber) {
            _phoneController.text = state.phoneNumber;
          }
          if (_baseWageController.text != state.baseWage) {
            _baseWageController.text = state.baseWage;
          }
        }
      },
      builder: (context, state) {
        final isEditing = state.mode == AddStaffMode.edit;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StaffInfoFields(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ),
            const SizedBox(height: 20),
            if (!isEditing) StaffPasswordField(controller: _passwordController),
            StaffRoleDropdown(initialRole: state.role),
            const SizedBox(height: 20),
            StaffFinancialFields(
              baseWageController: _baseWageController,
              initialWageType: state.wageType,
            ),
            const SizedBox(height: 20),
            StaffIdProofUpload(
              pickedIdProof: state.pickedIdProof,
              idProof: state.idProof,
            ),
          ],
        );
      },
    );
  }
}
