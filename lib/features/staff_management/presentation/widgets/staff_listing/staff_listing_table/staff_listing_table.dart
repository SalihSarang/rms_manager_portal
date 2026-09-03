import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/cubit/staff_pagination_cubit.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/staff_listing_table/staff_list_table_content.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';

class StaffListTable extends StatelessWidget {
  final List<StaffModel> staffList;

  static const int _itemsPerPage = 10;

  const StaffListTable({super.key, required this.staffList});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StaffPaginationCubit(),
      child: StaffListTableContent(
        staffList: staffList,
        itemsPerPage: _itemsPerPage,
      ),
    );
  }
}
