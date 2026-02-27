import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/sidebar_utils.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/components/staff_table_footer.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/components/staff_table_row.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/core/widgets/reusable_table.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/utils/dialog_utils.dart';

class StaffListTable extends StatefulWidget {
  final List<StaffModel> staffList;

  const StaffListTable({super.key, required this.staffList});

  @override
  State<StaffListTable> createState() => _StaffListTableState();
}

class _StaffListTableState extends State<StaffListTable> {
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    final List<StaffModel> sourceList = widget.staffList;
    final int totalItems = sourceList.length;
    final int totalPages = (totalItems / _itemsPerPage).ceil();

    if (totalItems > 0 && _currentPage > totalPages) {
      _currentPage = totalPages;
    }

    final int startIndex = (_currentPage - 1) * _itemsPerPage;
    final int endIndex = (startIndex + _itemsPerPage < totalItems)
        ? startIndex + _itemsPerPage
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
                  content: 'Are you sure you want to $action ${staff.name}?',
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
                final confirm = await DialogUtils.showDeleteConfirmationDialog(
                  context: context,
                  title: 'Delete Staff',
                  content: 'Are you sure you want to delete ${staff.name}?',
                  confirmLabel: 'Delete',
                );

                if (confirm == true && context.mounted) {
                  context.read<StaffListingBloc>().add(DeleteStaff(staff));
                }
              },
            ),
          ),
        ),
        if (totalItems > _itemsPerPage)
          StaffTableFooter(
            startIndex: startIndex,
            endIndex: endIndex,
            totalItems: totalItems,
            currentPage: _currentPage,
            totalPages: totalPages,
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
      ],
    );
  }
}
