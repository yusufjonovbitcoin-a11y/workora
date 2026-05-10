import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../home/presentation/providers/home_provider.dart';
import 'models/vacancy_detail_model.dart';
import 'widgets/vacancy_benefits_tab.dart';
import 'widgets/vacancy_bottom_actions.dart';
import 'widgets/vacancy_company_tab.dart';
import 'widgets/vacancy_detail_header.dart';
import 'widgets/vacancy_overview_tab.dart';
import 'widgets/vacancy_requirements_tab.dart';
import 'widgets/vacancy_reviews_tab.dart';
import 'widgets/vacancy_tabs.dart';

class VacancyDetailScreen extends ConsumerStatefulWidget {
  const VacancyDetailScreen({super.key, required this.vacancyId});

  final String vacancyId;

  @override
  ConsumerState<VacancyDetailScreen> createState() =>
      _VacancyDetailScreenState();
}

class _VacancyDetailScreenState extends ConsumerState<VacancyDetailScreen> {
  int selectedTabIndex = 0;
  bool isSaved = false;

  void _apply() {
    context.go('/apply-job');
  }

  void _message() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Xabar yuborish hozircha demo'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _share() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ulashish hozircha demo'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _selectedTab(VacancyDetailModel vacancy) {
    return switch (selectedTabIndex) {
      0 => VacancyOverviewTab(vacancy: vacancy),
      1 => VacancyRequirementsTab(vacancy: vacancy),
      2 => VacancyBenefitsTab(vacancy: vacancy),
      3 => VacancyCompanyTab(vacancy: vacancy),
      _ => VacancyReviewsTab(vacancy: vacancy),
    };
  }

  @override
  Widget build(BuildContext context) {
    final vacancyState = ref.watch(vacancyDetailProvider(widget.vacancyId));

    return vacancyState.when(
      loading: () => const Scaffold(
        backgroundColor: Color(0xFFF8FAFC),
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      ),
      error: (error, _) => Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Vakansiyani yuklab bo‘lmadi',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () =>
                        ref.invalidate(vacancyDetailProvider(widget.vacancyId)),
                    child: const Text('Qayta urinish'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      data: (vacancy) {
        if (vacancy == null) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Vakansiya topilmadi',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.go('/app'),
                        child: const Text('Bosh sahifaga qaytish'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          bottomNavigationBar: VacancyBottomActions(
            onMessage: _message,
            onApply: _apply,
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
              children: [
                VacancyDetailHeader(
                  vacancy: vacancy,
                  isSaved: isSaved,
                  onBack: () => context.go('/app'),
                  onSave: () => setState(() => isSaved = !isSaved),
                  onShare: _share,
                  onApply: _apply,
                ),
                const SizedBox(height: 22),
                VacancyTabs(
                  selectedIndex: selectedTabIndex,
                  onChanged: (index) =>
                      setState(() => selectedTabIndex = index),
                ),
                const SizedBox(height: 22),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: KeyedSubtree(
                    key: ValueKey(selectedTabIndex),
                    child: _selectedTab(vacancy),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
