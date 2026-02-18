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
        padding: const EdgeInsets.all(24.0),
        child: BlocListener<AddStaffBloc, AddStaffState>(
          listener: (context, state) {
            if (state is StaffCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.wasEditing
                        ? 'Staff updated successfully'
                        : 'Staff created successfully',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop(true);
            } else if (state is StaffCreateFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // Avatar
                BlocBuilder<AddStaffBloc, AddStaffState>(
                  builder: (context, state) {
                    String? avatarPath;
                    if (state is StaffEditingState) {
                      avatarPath = state.avatar;
                    }
                    return AddUserAvatar(
                      initials: 'UN',
                      onTap: () {
                        context.read<AddStaffBloc>().add(AvatarChanged());
                      },
                      image: avatarPath != null
                          ? ((kIsWeb || avatarPath.startsWith('http'))
                                    ? NetworkImage(avatarPath)
                                    : FileImage(File(avatarPath)))
                                as ImageProvider
                          : null,
                    );
                  },
                ),

                const SizedBox(height: 12),
                BlocBuilder<AddStaffBloc, AddStaffState>(
                  builder: (context, state) {
                    final isEditing =
                        state is StaffEditingState && state.isEditing;
                    return Text(
                      isEditing ? 'Edit User' : 'New User',
                      style: const TextStyle(
                        color: TextColors.inverse,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Fields
                AddStaffDialogFields(formKey: formKey),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
