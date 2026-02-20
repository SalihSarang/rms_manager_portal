import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class ReusableTable<T> extends StatelessWidget {
  final List<T> data;
  final List<DataColumn> columns;
  final DataRow Function(T item) rowBuilder;
  final bool headingRowColor;

  const ReusableTable({
    super.key,
    required this.data,
    required this.columns,
    required this.rowBuilder,
    this.headingRowColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      headingRowColor: WidgetStateProperty.all(
        NeutralColors.background,
      ), // Dark header color
      dataRowColor: WidgetStateProperty.all(Colors.transparent),
      headingTextStyle: const TextStyle(
        color: TextColors.secondary,
        fontWeight: FontWeight.bold,
      ),
      columns: columns,
      rows: data.map((item) => rowBuilder(item)).toList(),
      empty: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.transparent,
          child: const Text("No data available"),
        ),
      ),
    );
  }
}
