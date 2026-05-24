import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/staff_listing_table.dart';

import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// A container widget that observes the [StaffListingBloc] and displays the staff list.
///
/// It handles various states including loading, error (with retry),
/// and the empty state when no staff members are found.
class StaffListContainer extends StatelessWidget {
  /// Creates a [StaffListContainer].
  const StaffListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NeutralColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BlocBuilder<StaffListingBloc, StaffListingState>(
          builder: (context, state) {
            if (state is StaffListingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StaffListingLoaded) {
              if (state.staffs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline_rounded,
                        color: NeutralColors.border.withValues(alpha: 0.5),
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No staff members found',
                        style: TextStyle(
                          color: NeutralColors.border,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return StaffListTable(staffList: state.staffs);
            } else if (state is StaffListingError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: Color(0xFFE53935),
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFE53935),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<StaffListingBloc>().add(LoadStaffs());
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935).withValues(alpha: 0.1),
                        foregroundColor: const Color(0xFFE53935),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
