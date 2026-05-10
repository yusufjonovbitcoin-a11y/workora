import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_colors.dart';
import '../home/presentation/providers/home_provider.dart';
import 'data/models/add_submission_models.dart';
import 'forms/employer_form.dart';
import 'forms/job_seeker_form.dart';
import 'presentation/providers/add_provider.dart';
import 'widgets/add_header.dart';
import 'widgets/mode_switcher.dart';

class AddScreen extends ConsumerStatefulWidget {
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  bool isJobSeeker = true;
  bool isSubmitting = false;

  final professionController = TextEditingController();
  final jobTypeController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final experienceController = TextEditingController();
  final skillsController = TextEditingController();
  final educationController = TextEditingController();
  final languageController = TextEditingController();
  final aboutController = TextEditingController();
  final seekerContactController = TextEditingController();

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
    seekerContactController.dispose();
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

  Future<void> submit() async {
    if (isSubmitting) return;

    final error = isJobSeeker ? _validateJobSeeker() : _validateEmployer();
    if (error != null) {
      _showSnack(error, isError: true);
      return;
    }

    setState(() => isSubmitting = true);
    try {
      final repository = ref.read(addRepositoryProvider);
      if (isJobSeeker) {
        await repository.submitJobSeekerPost(
          JobSeekerPostInput(
            profession: _text(professionController),
            jobType: _text(jobTypeController),
            location: _text(locationController),
            expectedSalary: _text(salaryController),
            experience: _text(experienceController),
            skills: splitInputList(_text(skillsController)),
            education: _text(educationController),
            languages: splitInputList(_text(languageController)),
            about: _text(aboutController),
            contact: _text(seekerContactController),
          ),
        );
      } else {
        await repository.submitEmployerVacancy(
          EmployerVacancyInput(
            title: _text(vacancyTitleController),
            company: _text(companyController),
            jobType: _text(vacancyTypeController),
            location: _text(vacancyLocationController),
            salary: _text(vacancySalaryController),
            experience: _text(vacancyExperienceController),
            description: _text(vacancyAboutController),
            requirements: splitInputList(_text(requirementsController)),
            contact: _text(contactController),
          ),
        );
      }

      ref.invalidate(homeProvider);
      _clearCurrentForm();
      _showSnack(
        isJobSeeker
            ? 'Ish qidiruvchi anketasi saqlandi'
            : 'Vakansiya e’loni saqlandi',
      );
    } catch (error) {
      _showSnack(error.toString(), isError: true);
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  String? _validateJobSeeker() {
    final required = {
      'Lavozim / Kasb': professionController,
      'Ish turi': jobTypeController,
      'Ish joyi': locationController,
      'Maosh kutilgan': salaryController,
      'Tajriba': experienceController,
      'Bilim va ko‘nikmalar': skillsController,
      'Ta’lim': educationController,
      'O‘zingiz haqingizda': aboutController,
      'Aloqa ma’lumotlari': seekerContactController,
    };
    return _firstMissing(required);
  }

  String? _validateEmployer() {
    final required = {
      'Lavozim nomi': vacancyTitleController,
      'Kompaniya nomi': companyController,
      'Ish turi': vacancyTypeController,
      'Ish joyi': vacancyLocationController,
      'Maosh': vacancySalaryController,
      'Ish haqida ma’lumot': vacancyAboutController,
      'Aloqa ma’lumotlari': contactController,
    };
    return _firstMissing(required);
  }

  String? _firstMissing(Map<String, TextEditingController> fields) {
    for (final entry in fields.entries) {
      if (_text(entry.value).isEmpty) {
        return '${entry.key} maydonini to‘ldiring.';
      }
    }
    return null;
  }

  void _clearCurrentForm() {
    final controllers = isJobSeeker
        ? [
            professionController,
            jobTypeController,
            locationController,
            salaryController,
            experienceController,
            skillsController,
            educationController,
            languageController,
            aboutController,
            seekerContactController,
          ]
        : [
            vacancyTitleController,
            companyController,
            vacancyTypeController,
            vacancyLocationController,
            vacancySalaryController,
            vacancyExperienceController,
            vacancyAboutController,
            requirementsController,
            contactController,
          ];
    for (final controller in controllers) {
      controller.clear();
    }
  }

  String _text(TextEditingController controller) => controller.text.trim();

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.redAccent : AppColors.primary,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
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
                      contactController: seekerContactController,
                      onSubmit: submit,
                      isSubmitting: isSubmitting,
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
                      isSubmitting: isSubmitting,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
