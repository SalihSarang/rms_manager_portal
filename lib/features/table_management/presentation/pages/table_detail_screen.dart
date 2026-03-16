import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';

class TableDetailScreen extends StatelessWidget {
  final TableModel table;

  const TableDetailScreen({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeutralColors.background,
      appBar: AppBar(
        backgroundColor: NeutralColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: TextColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Table Details: ${table.name}',
          style: const TextStyle(color: TextColors.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 24),
            _buildPositionCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'General Information',
            style: TextStyle(color: TextColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildDetailRow('Table Name', table.name),
          _buildDetailRow('Capacity', '${table.capacity} Guests'),
          _buildDetailRow('Current Guests', '${table.currentGuests} Guests'),
          _buildDetailRow('Shape', table.shape.name.toUpperCase()),
          _buildDetailRow('Status', table.status.name.toUpperCase()),
          _buildDetailRow('Hall ID', table.hallId),
        ],
      ),
    );
  }

  Widget _buildPositionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border.withAlpha(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Layout Position',
            style: TextStyle(color: TextColors.primary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildDetailRow('X Position', table.posX.toStringAsFixed(2)),
          _buildDetailRow('Y Position', table.posY.toStringAsFixed(2)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: TextColors.secondary, fontSize: 14)),
          Text(value, style: const TextStyle(color: TextColors.primary, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
