import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_list_tile.dart';
import 'package:manager_portal/features/settings/presentation/widgets/settings/settings_section_card.dart';

class ApplicationLinksSection extends StatelessWidget {
  const ApplicationLinksSection({super.key});

  static const String _cashierPortalUrl = 'rms-cashier-portal.web.app';
  static const String _waiterPortalUrl =
      'https://apkpure.com/p/com.rms.waiter_portal';
  static const String _chefPortalUrl = 'rms-kds-portal.web.app';

  Future<void> _copyLink(BuildContext context, String label, String url) async {
    await Clipboard.setData(ClipboardData(text: url));
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$label link copied')));
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      title: 'APPLICATION LINKS',
      children: [
        SettingsListTile(
          icon: Icons.point_of_sale_outlined,
          title: 'Cashier Portal',
          subtitle: _cashierPortalUrl,
          trailing: const Icon(Icons.copy_outlined, size: 20),
          onTap: () => _copyLink(context, 'Cashier portal', _cashierPortalUrl),
        ),
        SettingsListTile(
          icon: Icons.room_service_outlined,
          title: 'Waiter Portal',
          subtitle: _waiterPortalUrl,
          trailing: const Icon(Icons.copy_outlined, size: 20),
          onTap: () => _copyLink(context, 'Waiter portal', _waiterPortalUrl),
        ),
        SettingsListTile(
          icon: Icons.soup_kitchen_outlined,
          title: 'Chef Portal',
          subtitle: _chefPortalUrl,
          trailing: const Icon(Icons.copy_outlined, size: 20),
          onTap: () => _copyLink(context, 'Chef portal', _chefPortalUrl),
          isLast: true,
        ),
      ],
    );
  }
}
