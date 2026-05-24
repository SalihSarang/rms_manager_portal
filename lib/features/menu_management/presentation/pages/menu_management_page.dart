import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/core/di/injector.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_bloc.dart';
import 'package:manager_portal/features/menu_management/presentation/bloc/add_category/add_category_event.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_management_appbar.dart';
import 'package:manager_portal/features/menu_management/presentation/widgets/menu_management_body.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';

/// Main dashboard for managing menu categories and food items.
///
/// This page provides a dual-pane layout with a category sidebar on the left
/// and the selected category's food items on the right.
class MenuManagementPage extends StatelessWidget {
  /// Creates a [MenuManagementPage].
  const MenuManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddCategoryBloc>()..add(LoadCategories()),
      child: const Scaffold(
        backgroundColor: NeutralColors.background,
        appBar: MenuManagementAppBar(),
        body: MenuManagementBody(),
      ),
    );
  }
}
