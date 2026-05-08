import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data/vacancy_detail_mock_data.dart';
import 'models/vacancy_detail_model.dart';
import 'widgets/vacancy_benefits_tab.dart';
import 'widgets/vacancy_bottom_actions.dart';
import 'widgets/vacancy_company_tab.dart';
import 'widgets/vacancy_detail_header.dart';
import 'widgets/vacancy_overview_tab.dart';
import 'widgets/vacancy_requirements_tab.dart';
import 'widgets/vacancy_reviews_tab.dart';
import 'widgets/vacancy_tabs.dart';

class VacancyDetailScreen extends StatefulWidget {
  const VacancyDetailScreen({super.key});

  @override
  State<VacancyDetailScreen> createState() => _VacancyDetailScreenState();
}

class _VacancyDetailScreenState extends State<VacancyDetailScreen> {
  final VacancyDetailModel vacancy = VacancyDetailMockData.vacancy;
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

  Widget _selectedTab() {
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
              onChanged: (index) => setState(() => selectedTabIndex = index),
            ),
            const SizedBox(height: 22),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: KeyedSubtree(
                key: ValueKey(selectedTabIndex),
                child: _selectedTab(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
