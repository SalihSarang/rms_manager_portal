import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class WaitStaffLeaderboardContent extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  const WaitStaffLeaderboardContent({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryHeader(),
          const SizedBox(height: 32),
          _buildLeaderboardList(),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    final totalRevenue = entries.fold(0.0, (sum, e) => sum + e.revenue);
    final totalOrders = entries.fold(0, (sum, e) => sum + e.ordersCount);

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            icon: Icons.group_outlined,
            label: 'Total Staff',
            value: '${entries.length}',
            color: PrimaryColors.defaultColor,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildSummaryCard(
            icon: Icons.shopping_cart_outlined,
            label: 'Total Orders',
            value: '$totalOrders',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: _buildSummaryCard(
            icon: Icons.attach_money,
            label: 'Total Revenue',
            value: '\$${totalRevenue.toStringAsFixed(2)}',
            color: PrimaryColors.brandGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: TextColors.muted, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardList() {
    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTableHeader(),
          const Divider(height: 1, color: NeutralColors.border),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: entries.length,
            separatorBuilder: (context, index) => const Divider(height: 1, color: NeutralColors.border, indent: 72),
            itemBuilder: (context, index) {
              return _buildStaffRow(entries[index], index + 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          SizedBox(width: 48),
          Expanded(
            flex: 3,
            child: Text('STAFF', style: _headerStyle),
          ),
          Expanded(
            flex: 2,
            child: Text('ORDERS', textAlign: TextAlign.center, style: _headerStyle),
          ),
          Expanded(
            flex: 2,
            child: Text('REVENUE', textAlign: TextAlign.right, style: _headerStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffRow(LeaderboardEntry entry, int rank) {
    final rankColor = rank == 1
        ? const Color(0xFFFFD700)
        : rank == 2
            ? const Color(0xFFC0C0C0)
            : rank == 3
                ? const Color(0xFFCD7F32)
                : TextColors.muted;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: rank <= 3
                ? Icon(Icons.workspace_premium, color: rankColor, size: 22)
                : Text(
                    '#$rank',
                    style: const TextStyle(
                      color: TextColors.muted,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(entry.staff.avatar),
            backgroundColor: NeutralColors.border,
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.staff.name,
                  style: const TextStyle(
                    color: TextColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  entry.staff.email,
                  style: const TextStyle(color: TextColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${entry.ordersCount}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: TextColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '\$${entry.revenue.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: PrimaryColors.brandGreen,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    color: TextColors.muted,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}
