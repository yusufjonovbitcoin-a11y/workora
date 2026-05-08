import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'forms/employer_form.dart';
import 'forms/job_seeker_form.dart';
import 'widgets/add_header.dart';
import 'widgets/mode_switcher.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool isJobSeeker = true;

  final professionController = TextEditingController();
  final jobTypeController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final experienceController = TextEditingController();
  final skillsController = TextEditingController();
  final educationController = TextEditingController();
  final languageController = TextEditingController();
  final aboutController = TextEditingController();

  final vacancyTitleController = TextEditingController();
  final companyController = TextEditingController();
  final vacancyTypeController = TextEditingController();
  final vacancyLocationController = TextEditingController();
  final vacancySalaryController = TextEditingController();
  final vacancyExperienceController = TextEditingController();
  final vacancyAboutController = TextEditingController();
  final requirementsController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    professionController.dispose();
    jobTypeController.dispose();
    locationController.dispose();
    salaryController.dispose();
    experienceController.dispose();
    skillsController.dispose();
    educationController.dispose();
    languageController.dispose();
    aboutController.dispose();
    vacancyTitleController.dispose();
    companyController.dispose();
    vacancyTypeController.dispose();
    vacancyLocationController.dispose();
    vacancySalaryController.dispose();
    vacancyExperienceController.dispose();
    vacancyAboutController.dispose();
    requirementsController.dispose();
    contactController.dispose();
    super.dispose();
  }

  void submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        content: Text(
          isJobSeeker
              ? 'Ish qidiruvchi e’loni saqlandi ✅'
              : 'Vakansiya e’loni saqlandi ✅',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
          children: [
            const AddHeader(),
            const SizedBox(height: 24),
            ModeSwitcher(
              isJobSeeker: isJobSeeker,
              onChanged: (value) {
                setState(() {
                  isJobSeeker = value;
                });
              },
            ),
            const SizedBox(height: 24),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: isJobSeeker
                  ? JobSeekerForm(
                      key: const ValueKey('job_seeker'),
                      professionController: professionController,
                      jobTypeController: jobTypeController,
                      locationController: locationController,
                      salaryController: salaryController,
                      experienceController: experienceController,
                      skillsController: skillsController,
                      educationController: educationController,
                      languageController: languageController,
                      aboutController: aboutController,
                      onSubmit: submit,
                    )
                  : EmployerForm(
                      key: const ValueKey('employer'),
                      vacancyTitleController: vacancyTitleController,
                      companyController: companyController,
                      vacancyTypeController: vacancyTypeController,
                      vacancyLocationController: vacancyLocationController,
                      vacancySalaryController: vacancySalaryController,
                      vacancyExperienceController: vacancyExperienceController,
                      vacancyAboutController: vacancyAboutController,
                      requirementsController: requirementsController,
                      contactController: contactController,
                      onSubmit: submit,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
