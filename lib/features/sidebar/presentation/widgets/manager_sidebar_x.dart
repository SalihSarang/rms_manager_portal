import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:manager_portal/features/auth/presentation/bloc/auth_event.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import '../utils/sidebar_theme.dart';

/// A customized [SidebarX] for the manager portal.
///
/// It displays navigation items and a logout button in the footer.
class ManagerSidebarX extends StatelessWidget {
  /// Creates a [ManagerSidebarX] with the required [controller].
  const ManagerSidebarX({super.key, required SidebarXController controller})
    : _controller = controller;

  /// The controller that manages the sidebar's selection and expansion state.
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      showToggleButton: true,
      theme: ManagerSidebarTheme.mainTheme,
      extendedTheme: ManagerSidebarTheme.extendedTheme,
      footerDivider: Divider(color: NeutralColors.border),
      headerBuilder: (context, extended) {
        return SizedBox(height: 30);
      },
      footerBuilder: (context, extended) {
        return Column(
          children: [
            ListTile(
              onTap: () {
                debugPrint('Logout tapped');
                context.read<AuthBloc>().add(LogOutSubmitted());
              },
              leading: const Icon(
                Icons.logout,
                color: SemanticColors.error,
                size: 24,
              ),
              title: extended
                  ? const Text(
                      'Logout',
                      style: TextStyle(color: TextColors.secondary),
                    )
                  : null,
            ),
          ],
        );
      },
      items: const [
        SidebarXItem(icon: Icons.grid_view_rounded, label: 'Overview'),
        SidebarXItem(icon: Icons.people_alt_outlined, label: 'Employees'),
        SidebarXItem(icon: Icons.inventory_2_outlined, label: 'Products'),
        SidebarXItem(icon: Icons.table_restaurant_outlined, label: 'Tables'),
        SidebarXItem(icon: Icons.analytics_outlined, label: 'Reports'),
      ],
    );
  }
}
