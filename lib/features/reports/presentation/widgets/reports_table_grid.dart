import 'package:flutter/material.dart';
import 'package:rms_shared_package/enums/enums.dart';
import '../bloc/reports_state.dart';
import 'table_status_card.dart';

class ReportsTableGrid extends StatelessWidget {
  final ReportsLoaded state;

  const ReportsTableGrid({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1.4,
      ),
      itemCount: state.tables.length,
      itemBuilder: (context, index) {
        final table = state.tables[index];
        String? waiter;
        String? duration;

        if (table.status != TableStatus.available) {
          waiter = index % 3 == 0
              ? 'Alex Miller'
              : (index % 3 == 1 ? 'Sarah Jenkins' : 'David Kim');
          duration = '${(index + 1) * 12}m';
          if (index == 2) duration = '1h 15m';
          if (index == 7) duration = '3h 12m';
        }

        return TableStatusCard(
          table: table,
          waiterName: waiter,
          duration: duration,
          activeOrders: state.tableOrders[table.id] ?? [],
        );
      },
    );
  }
}
