import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/dialog_fields.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/enums/enums.dart';

class StaffFinancialFields extends StatelessWidget {
  final TextEditingController baseWageController;
  final WageType? initialWageType;

  const StaffFinancialFields({
    super.key,
    required this.baseWageController,
    this.initialWageType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabeledTextField(
          label: 'Base Wage',
          hint: 'e.g. 500.0',
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          controller: baseWageController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          onChanged: (value) =>
              context.read<AddStaffBloc>().add(BaseWageChanged(value)),
        ),
        const SizedBox(height: 20),
        const Text(
          'Wage Type',
          style: TextStyle(
            color: TextColors.secondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<WageType>(
          initialValue: initialWageType,
          hint: const Text('Select Wage Type',
              style: TextStyle(color: TextColors.muted)),
          decoration: InputDecoration(
            filled: true,
            fillColor: NeutralColors.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: NeutralColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: NeutralColors.border),
            ),
          ),
          dropdownColor: NeutralColors.surface,
          items: WageType.values.map((type) {
            return DropdownMenuItem(
              value: type,
              child: Text(
                type.name[0].toUpperCase() + type.name.substring(1),
                style: const TextStyle(color: TextColors.primary),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<AddStaffBloc>().add(WageTypeChanged(value));
            }
          },
        ),
      ],
    );
  }
}
