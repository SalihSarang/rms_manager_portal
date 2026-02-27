import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'components/glass_card.dart';
import 'components/glass_divider.dart';
import 'components/card_header.dart';
import 'components/verify_row.dart';

class StaffDetailsContactCard extends StatelessWidget {
  final StaffModel staff;

  const StaffDetailsContactCard({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return StaffDetailsGlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StaffDetailsCardHeader(
            icon: Icons.contacts_outlined,
            title: 'Contact Details',
          ),
          const StaffDetailsGlassDivider(),
          StaffDetailsVerifyRow(
            icon: Icons.email_outlined,
            label: 'Email',
            value: staff.email,
            isEmpty: staff.email.isEmpty,
          ),
          StaffDetailsVerifyRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: staff.phoneNumber,
            isEmpty: staff.phoneNumber.isEmpty,
          ),
        ],
      ),
    );
  }
}
