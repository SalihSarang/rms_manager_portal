import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/overview/domain/entities/timeframe.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_bloc.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_event.dart';
import 'package:manager_portal/features/overview/presentation/bloc/overview_state.dart';
import 'package:manager_portal/features/overview/presentation/widgets/overview/date_range_picker_dialog.dart';
import 'package:rms_design_system/rms_design_system.dart';
import 'package:intl/intl.dart';

class OverviewFilterSection extends StatelessWidget {
  const OverviewFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OverviewBloc, OverviewState>(
      builder: (context, state) {
        if (state is! OverviewLoaded) return const SizedBox();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: NeutralColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildFilterLabel(),
              const SizedBox(width: 24),
              _buildTimeframeSelector(context, state),
              const SizedBox(width: 16),
              if (state.timeframe == Timeframe.custom) _buildDateDisplay(context, state),
              const Spacer(),
              _buildQuickActions(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterLabel() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: PrimaryColors.defaultColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.filter_list,
            size: 18,
            color: PrimaryColors.defaultColor,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          'Filters',
          style: TextStyle(
            color: TextColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeframeSelector(BuildContext context, OverviewLoaded state) {
    return InkWell(
      onTap: () async {
        final result = await RMSDateRangePickerDialog.show(
          context,
          initialStartDate: state.startDate,
          initialEndDate: state.endDate,
          initialTimeframe: state.timeframe,
        );

        if (result != null && context.mounted) {
          context.read<OverviewBloc>().add(
                LoadOverviewData(
                  timeframe: result['timeframe'] as Timeframe,
                  startDate: result['startDate'] as DateTime?,
                  endDate: result['endDate'] as DateTime?,
                ),
              );
        }
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: NeutralColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: NeutralColors.border),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: PrimaryColors.defaultColor,
            ),
            const SizedBox(width: 10),
            Text(
              state.timeframe == Timeframe.custom ? 'Custom Range' : state.timeframe.label,
              style: const TextStyle(
                color: TextColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 20,
              color: TextColors.secondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateDisplay(BuildContext context, OverviewLoaded state) {
    if (state.startDate == null || state.endDate == null) return const SizedBox();

    final dateFormat = DateFormat('MMM dd, yyyy');
    final rangeText = '${dateFormat.format(state.startDate!)} - ${dateFormat.format(state.endDate!)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: PrimaryColors.defaultColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: PrimaryColors.defaultColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Text(
            rangeText,
            style: TextStyle(
              color: PrimaryColors.defaultColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              context.read<OverviewBloc>().add(const LoadOverviewData(timeframe: Timeframe.last7Days));
            },
            child: Icon(
              Icons.close_rounded,
              size: 16,
              color: PrimaryColors.defaultColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        _buildActionButton(
          icon: Icons.refresh_rounded,
          tooltip: 'Refresh Data',
          onTap: () {
            final state = context.read<OverviewBloc>().state;
            if (state is OverviewLoaded) {
              context.read<OverviewBloc>().add(
                    LoadOverviewData(
                      timeframe: state.timeframe,
                      startDate: state.startDate,
                      endDate: state.endDate,
                    ),
                  );
            }
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: NeutralColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: TextColors.secondary,
          ),
        ),
      ),
    );
  }
}
