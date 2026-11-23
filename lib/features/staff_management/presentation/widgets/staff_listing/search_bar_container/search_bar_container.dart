import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/bloc/staff_listing/staff_listing_bloc.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/search_bar_container/components/dearchbar.dart';
import 'package:manager_portal/features/staff_management/presentation/widgets/staff_listing/search_bar_container/components/staff_filter_chips.dart';
import 'package:rms_design_system/app_colors/neutral_colors.dart';
import 'package:rms_design_system/app_colors/text_colors.dart';

class SearchBarContainer extends StatefulWidget {
  const SearchBarContainer({super.key});

  @override
  State<SearchBarContainer> createState() => _SearchBarContainerState();
}

class _SearchBarContainerState extends State<SearchBarContainer> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StaffListingBloc, StaffListingState>(
      listener: (context, state) {
        if (state is StaffListingLoaded) {
          if (state.searchQuery != _searchController.text) {
            _searchController.text = state.searchQuery;
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: NeutralColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: NeutralColors.border),
        ),
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final searchBar = PrimarySearchBar(
              controller: _searchController,
              hintText: 'Search staff by name, email, phone, or role...',
              width: double.infinity,
              height: 40,
              backgroundColor: NeutralColors.background,
              iconColor: NeutralColors.icon,
              textColor: TextColors.primary,
              onChanged: (value) {
                context.read<StaffListingBloc>().add(SearchStaff(value));
              },
              onClear: () {
                _searchController.clear();
                context.read<StaffListingBloc>().add(const SearchStaff(''));
              },
            );

            if (constraints.maxWidth < 900) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  searchBar,
                  const SizedBox(height: 12),
                  const StaffFilterChips(),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(child: searchBar),
                  const SizedBox(width: 20),
                  const StaffFilterChips(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
