import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff/presentation/bloc/add_staff/add_staff_bloc.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/dialog_avatar.dart';
import 'package:manager_portal/features/staff/presentation/widgets/add_staff_sidebar/components/dialog_form.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SidebarBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const SidebarBody({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Picker
              Center(
                child: BlocConsumer<AddStaffBloc, AddStaffState>(
                  listener: (context, state) {
                    if (state.status == AddStaffStatus.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.mode == AddStaffMode.edit
                                ? 'Staff updated successfully'
                                : 'Staff created successfully',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      context.read<AddStaffBloc>().add(CloseAddStaffSidebar());
                      Navigator.of(context).pop(true);
                    } else if (state.status == AddStaffStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorMessage ?? 'Unknown error'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isEditing = state.mode == AddStaffMode.edit;
                    final avatarPath = state.avatar;
                    final pickedFile = state.pickedFile;

                    ImageProvider? imageProvider;
                    if (pickedFile != null) {
                      if (kIsWeb) {
                        imageProvider = NetworkImage(pickedFile.path);
                      } else {
                        imageProvider = FileImage(File(pickedFile.path));
                      }
                    } else if (avatarPath.isNotEmpty) {
                      imageProvider = NetworkImage(avatarPath);
                    }

                    return Column(
                      children: [
                        AddUserAvatar(
                          initials: state.fullName.isNotEmpty
                              ? state.fullName.length >= 2
                                    ? state.fullName
                                          .substring(0, 2)
                                          .toUpperCase()
                                    : state.fullName.toUpperCase()
                              : 'UN',
                          image: imageProvider,
                          onTap: () {
                            context.read<AddStaffBloc>().add(AvatarChanged());
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isEditing ? 'Edit User' : 'New User',
                          style: const TextStyle(
                            color: TextColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // Form Fields
              AddStaffDialogFields(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}
