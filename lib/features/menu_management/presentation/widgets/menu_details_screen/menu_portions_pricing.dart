import 'package:flutter/material.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

class MenuPortionsPricing extends StatelessWidget {
  final List<PortionAndPrice> portions;

  const MenuPortionsPricing({super.key, required this.portions});

  @override
  Widget build(BuildContext context) {
    if (portions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Portions & Pricing',
          style: TextStyle(
            color: TextColors.inverse,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: NeutralColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: NeutralColors.border.withValues(alpha: 0.5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header Row
              _buildHeader(),
              Divider(
                color: NeutralColors.border.withValues(alpha: 0.5),
                height: 1,
              ),
              // Data Rows
              ...portions.map((p) => _buildDataRow(p)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(flex: 3, child: _headerText('Name')),
          Expanded(flex: 1, child: _headerText('Count')),
          Expanded(flex: 1, child: _headerText('Unit')),
          Expanded(flex: 1, child: _headerText('Price')),
        ],
      ),
    );
  }

  Widget _headerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: TextColors.secondary,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );
  }

  Widget _buildDataRow(PortionAndPrice p) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  p.name,
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  p.count?.toString() ?? '-',
                  style: const TextStyle(color: TextColors.secondary),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  p.unit ?? '-',
                  style: const TextStyle(color: TextColors.secondary),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '\$${p.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: TextColors.inverse,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (portions.last != p)
          Divider(
            color: NeutralColors.border.withValues(alpha: 0.5),
            height: 1,
          ),
      ],
    );
  }
}
