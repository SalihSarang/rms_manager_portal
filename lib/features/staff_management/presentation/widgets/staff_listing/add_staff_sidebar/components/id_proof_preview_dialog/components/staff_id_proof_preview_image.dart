import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/add_staff_sidebar/components/id_proof_preview_dialog/components/staff_id_proof_preview_error.dart';

class StaffIdProofPreviewImage extends StatelessWidget {
  final XFile? pickedIdProof;
  final String idProof;

  const StaffIdProofPreviewImage({
    super.key,
    this.pickedIdProof,
    this.idProof = '',
  });

  @override
  Widget build(BuildContext context) {
    if (pickedIdProof != null) {
      if (kIsWeb) {
        return Image.network(
          pickedIdProof!.path,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const StaffIdProofPreviewError(),
        );
      } else {
        return Image.file(
          File(pickedIdProof!.path),
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              const StaffIdProofPreviewError(),
        );
      }
    } else if (idProof.isNotEmpty) {
      return Image.network(
        idProof,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) =>
            const StaffIdProofPreviewError(),
      );
    }
    return const StaffIdProofPreviewError(message: 'No image available');
  }
}
