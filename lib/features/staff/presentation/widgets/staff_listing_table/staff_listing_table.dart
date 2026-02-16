import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'package:manager_portal/core/widgets/reusable_table.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/primary_colors.dart';
import 'package:manager_portal/features/staff/presentation/widgets/staff_listing_table/components/action_button.dart';
import 'package:manager_portal/features/staff/presentation/widgets/staff_listing_table/components/staff_table_footer.dart';
import 'package:manager_portal/features/staff/presentation/utils/staff_utils.dart';

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

    // Ensure valid page
    if (totalItems > 0 && _currentPage > totalPages) {
      _currentPage = totalPages;
    }

    final int startIndex = (_currentPage - 1) * _itemsPerPage;
    final int endIndex = (startIndex + _itemsPerPage < totalItems)
        ? startIndex + _itemsPerPage
        : totalItems;

    // Safety check for empty list
    final List<StaffModel> currentData = sourceList.isEmpty
        ? []
        : sourceList.sublist(startIndex, endIndex);

    return Column(
      children: [
        Expanded(
          child: ReusableTable<StaffModel>(
            data: currentData,
            columns: const [
              DataColumn2(label: Text('Name'), size: ColumnSize.L),
              DataColumn2(label: Text('Role')),
              DataColumn2(label: Text('Email Address'), size: ColumnSize.L),
              DataColumn2(label: Text('Last Active')),
              DataColumn2(label: Text('Actions'), fixedWidth: 80),
            ],
            rowBuilder: (staff) => _buildStaffRow(staff),
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

  DataRow2 _buildStaffRow(StaffModel staff) {
    const headerTextColor = TextColors.secondary;
    const badgeBgColor = NeutralColors.surface;
    const badgeTextColor = PrimaryColors.defaultColor;
    const badgeBorderColor = NeutralColors.border;

    return DataRow2(
      cells: [
        // Name
        DataCell(
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF272B34),
                radius: 16,
                child: Text(
                  StaffUtils.getInitials(staff.name),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  staff.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        // Role
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: badgeBorderColor),
            ),
            child: Text(
              staff.role.name.toUpperCase(),
              style: const TextStyle(
                color: badgeTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        // Email
        DataCell(
          Text(staff.email, style: const TextStyle(color: headerTextColor)),
        ),
        // Last Active
        DataCell(
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: headerTextColor),
              const SizedBox(width: 6),
              Text(
                StaffUtils.formatDate(staff.lastActive),
                style: const TextStyle(color: headerTextColor),
              ),
            ],
          ),
        ),
        // Actions
        DataCell(
          Row(
            children: [
              ActionButton(icon: Icons.edit_outlined, onTap: () {}),
              const SizedBox(width: 8),
              ActionButton(icon: Icons.delete_outline, onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
