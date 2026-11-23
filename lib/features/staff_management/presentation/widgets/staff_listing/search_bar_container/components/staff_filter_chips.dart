import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class StaffFilterChips extends StatelessWidget {
  const StaffFilterChips({super.key});

  static const List<String> _filters = ['All', 'Chef', 'Waiter', 'Cashier'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffListingBloc, StaffListingState>(
      builder: (context, state) {
        final String selectedFilter = (state is StaffListingLoaded)
            ? state.selectedRole
            : 'All';

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _filters.map((filter) {
              final isSelected = selectedFilter.toLowerCase() == filter.toLowerCase();
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () {
                    context.read<StaffListingBloc>().add(FilterStaffByRole(filter));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? PrimaryColors.defaultColor
                          : NeutralColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? PrimaryColors.defaultColor
                            : NeutralColors.border,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected
                            ? TextColors.primary
                            : TextColors.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
