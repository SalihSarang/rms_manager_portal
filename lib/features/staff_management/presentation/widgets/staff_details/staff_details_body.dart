import 'package:flutter/material.dart';
import 'package:rms_shared_package/models/staff_model/staff_model.dart';
import 'identity_card.dart';
import 'contact_card.dart';
import 'role_status_card.dart';
import 'id_proof_card.dart';

/// The main body content for the staff details screen.
///
/// Arranges various cards (identity, contact, status, ID proof) in a
/// responsive layout based on the available width.
class StaffDetailsBody extends StatelessWidget {
  /// The [StaffModel] whose details are being displayed.
  final StaffModel staff;

  /// Creates a [StaffDetailsBody] for the given [staff].
  const StaffDetailsBody({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StaffDetailsIdentityCard(staff: staff),
              const SizedBox(height: 16),
              if (isWide)
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: StaffDetailsContactCard(staff: staff)),
                      const SizedBox(width: 14),
                      Expanded(child: StaffDetailsRoleStatusCard(staff: staff)),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    StaffDetailsContactCard(staff: staff),
                    const SizedBox(height: 14),
                    StaffDetailsRoleStatusCard(staff: staff),
                  ],
                ),
              const SizedBox(height: 14),
              // Card 3 – ID Proof
              StaffDetailsIdProofCard(staff: staff),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
