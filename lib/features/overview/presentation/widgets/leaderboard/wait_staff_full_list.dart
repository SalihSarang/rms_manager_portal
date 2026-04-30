import 'package:flutter/material.dart';
import 'package:manager_portal/features/overview/domain/entities/overview_data.dart';
import 'package:rms_design_system/rms_design_system.dart';

class WaitStaffFullList extends StatelessWidget {
  final List<LeaderboardEntry> restEntries;

  const WaitStaffFullList({super.key, required this.restEntries});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: NeutralColors.border),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const Divider(height: 1, color: NeutralColors.border),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restEntries.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: NeutralColors.border,
              indent: 72,
            ),
            itemBuilder: (context, index) {
              final entry = restEntries[index];
              final rank = index + 4;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text(
                        '#$rank',
                        style: const TextStyle(
                          color: TextColors.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                            style: const TextStyle(
                              color: TextColors.muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${entry.ordersCount} Orders',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: TextColors.primary,
                          fontSize: 14,
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
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(width: 40),
          SizedBox(width: 40),
          SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text(
              'STAFF NAME',
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'TOTAL ORDERS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'REVENUE',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: TextColors.muted,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
