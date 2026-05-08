import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/foreign_jobs_provider.dart';
import '../widgets/country_list.dart';
import '../widgets/foreign_big_banner.dart';
import '../widgets/foreign_jobs_header.dart';
import '../widgets/foreign_program_card.dart';
import '../widgets/foreign_search_bar.dart';
import '../widgets/foreign_section_header.dart';
import '../widgets/region_chips.dart';

class ForeignJobsScreen extends ConsumerWidget {
  const ForeignJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(foreignJobsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
          children: [
            const ForeignJobsHeader(),
            const SizedBox(height: 26),
            const ForeignSearchBar(),
            const SizedBox(height: 20),
            RegionChips(regions: state.regions),
            const SizedBox(height: 26),
            const ForeignBigBanner(),
            const SizedBox(height: 28),
            const ForeignSectionHeader(title: 'Mashhur davlatlar'),
            const SizedBox(height: 16),
            CountryList(countries: state.countries),
            const SizedBox(height: 28),
            const ForeignSectionHeader(title: 'Tavsiya etilgan dasturlar'),
            const SizedBox(height: 16),
            ...state.programs.map(
              (program) => ForeignProgramCard(program: program),
            ),
          ],
        ),
      ),
    );
  }
}
