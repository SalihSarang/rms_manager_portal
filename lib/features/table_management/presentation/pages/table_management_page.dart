import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

/// A page for managing the restaurant's table layout.
///
/// This screen allows managers to visualize, add, and arrange tables.
class TableManagementPage extends StatelessWidget {
  /// Creates a [TableManagementPage].
  const TableManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: AppBar(
        backgroundColor: NeutralColors.background,
        elevation: 0,
        title: const Text(
          'Table Management',
          style: TextStyle(
            color: TextColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.table_restaurant_outlined,
              size: 64,
              color: TextColors.secondary,
            ),
            SizedBox(height: 16),
            Text(
              'Table Management Screen',
              style: TextStyle(
                fontSize: 20,
                color: TextColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This feature is under development.',
              style: TextStyle(
                color: TextColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
