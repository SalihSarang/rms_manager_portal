import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/utils/dialog_utils.dart';
import 'package:manager_portal/core/widgets/reusable_table.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/cubit/staff_pagination_cubit.dart';
import 'package:manager_portal/features/staff_management/presentation/pages/staff_details_screen.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/sidebar_utils.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/components/staff_table_footer.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/components/staff_table_row.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class StaffListTableContent extends StatelessWidget {
  final List<StaffModel> staffList;
  final int itemsPerPage;

  const StaffListTableContent({
    super.key,
    required this.staffList,
    required this.itemsPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffPaginationCubit, int>(
      builder: (context, currentPage) {
        final List<StaffModel> sourceList = staffList;
        final int totalItems = sourceList.length;
        final int totalPages = (totalItems / itemsPerPage).ceil();

        final cubit = context.read<StaffPaginationCubit>();
        cubit.clampPage(totalPages);

        final int safePage = (totalPages > 0 && currentPage > totalPages)
            ? totalPages
            : currentPage;

        final int startIndex = (safePage - 1) * itemsPerPage;
        final int endIndex = (startIndex + itemsPerPage < totalItems)
            ? startIndex + itemsPerPage
            : totalItems;

        final List<StaffModel> currentData = sourceList.isEmpty
            ? []
            : sourceList.sublist(startIndex, endIndex);

        return Column(
          children: [
            Expanded(
              child: ReusableTable<StaffModel>(
                data: currentData,
                columns: const [
                  DataColumn2(label: Text('#'), fixedWidth: 50),
                  DataColumn2(label: Text('Name'), size: ColumnSize.L),
                  DataColumn2(label: Text('Role')),
                  DataColumn2(label: Text('Email Address'), size: ColumnSize.L),
                  DataColumn2(label: Text('Status')),
                  DataColumn2(label: Text('Last Active')),
                  DataColumn2(label: Text('Actions'), fixedWidth: 80),
                ],
                rowBuilder: (staff) => StaffTableRow(
                  index: startIndex + currentData.indexOf(staff) + 1,
                  staff: staff,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => StaffDetailsScreen(staffId: staff.id),
                    ),
                  ),
                  onEdit: () async {
                    final result = await showAddStaffSidebar(
                      context,
                      staffToEdit: staff,
                    );
                    if (result == true && context.mounted) {
                      context.read<StaffListingBloc>().add(LoadStaffs());
                    }
                  },
                  onToggleStatus: () async {
                    final action = staff.isActive ? 'block' : 'unblock';
                    final confirm = await DialogUtils.showDeleteConfirmationDialog(
                      context: context,
                      title:
                          '${action[0].toUpperCase()}${action.substring(1)} Staff',
                      content:
                          'Are you sure you want to $action ${staff.name}?',
                      confirmLabel:
                          '${action[0].toUpperCase()}${action.substring(1)}',
                    );

                    if (confirm == true && context.mounted) {
                      context.read<StaffListingBloc>().add(
                        ToggleStaffStatus(staff: staff),
                      );
                    }
                  },
                  onDelete: () async {
                    final confirm =
                        await DialogUtils.showDeleteConfirmationDialog(
                          context: context,
                          title: 'Delete Staff',
                          content:
                              'Are you sure you want to delete ${staff.name}?',
                          confirmLabel: 'Delete',
                        );

                    if (confirm == true && context.mounted) {
                      context.read<StaffListingBloc>().add(DeleteStaff(staff));
                    }
                  },
                ),
              ),
            ),
            if (totalItems > itemsPerPage)
              StaffTableFooter(
                startIndex: startIndex,
                endIndex: endIndex,
                totalItems: totalItems,
                currentPage: safePage,
                totalPages: totalPages,
                onPageChanged: (page) =>
                    context.read<StaffPaginationCubit>().goToPage(page),
              ),
          ],
        );
      },
    );
  }
}
