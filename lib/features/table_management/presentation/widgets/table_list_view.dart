import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/semantic_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/table_model/table_model.dart';
import 'package:manager_portal/features/table_management/presentation/pages/table_detail_screen.dart';

class TableListView extends StatelessWidget {
  final List<TableModel> tables;

  const TableListView({super.key, required this.tables});

  @override
  Widget build(BuildContext context) {
    if (tables.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.table_restaurant_outlined,
              size: 64,
              color: NeutralColors.border,
            ),
            const SizedBox(height: 16),
            Text(
              'No tables found',
              style: TextStyle(color: TextColors.secondary, fontSize: 18),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2D),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NeutralColors.border.withAlpha(25)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFF2A2A3C)),
          dataRowMinHeight: 70,
          dataRowMaxHeight: 70,
          columns: const [
            DataColumn(
              label: Text(
                'NAME',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'CAPACITY',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'SHAPE',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'STATUS',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'ACTIONS',
                style: TextStyle(
                  color: TextColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          rows: tables.map((table) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    table.name,
                    style: const TextStyle(color: TextColors.primary),
                  ),
                ),
                DataCell(
                  Text(
                    '${table.capacity} Guests',
                    style: const TextStyle(color: TextColors.secondary),
                  ),
                ),
                DataCell(
                  Text(
                    table.shape.name.toUpperCase(),
                    style: const TextStyle(color: TextColors.secondary),
                  ),
                ),
                DataCell(_buildStatusChip(table.status)),
                DataCell(
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: TextColors.secondary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TableDetailScreen(table: table),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusChip(TableStatus status) {
    Color color;
    switch (status) {
      case TableStatus.available:
        color = SemanticColors.success;
        break;
      case TableStatus.occupied:
        color = SemanticColors.error;
        break;
      case TableStatus.partiallyOccupied:
        color = SemanticColors.warning;
        break;
      case TableStatus.disabled:
        color = NeutralColors.border;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(128)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
