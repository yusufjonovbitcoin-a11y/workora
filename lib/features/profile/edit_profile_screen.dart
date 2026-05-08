import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'data/profile_mock_data.dart';
import 'models/experience_model.dart';
import 'models/language_model.dart';
import 'models/skill_model.dart';
import 'widgets/editable_text_field.dart';
import 'widgets/experience_tile.dart';
import 'widgets/language_tile.dart';
import 'widgets/profile_avatar_picker.dart';
import 'widgets/profile_info_section.dart';
import 'widgets/skill_chip.dart';
import 'widgets/upload_cv_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profile = ProfileMockData.profile;

  late final fullNameController = TextEditingController(text: profile.fullName);
  late final professionController = TextEditingController(
    text: profile.profession,
  );
  late final bioController = TextEditingController(text: profile.bio);
  late final phoneController = TextEditingController(text: profile.phone);
  late final locationController = TextEditingController(text: profile.location);

  late final List<SkillModel> skills = [...profile.skills];
  late final List<LanguageModel> languages = [...profile.languages];
  late final List<ExperienceModel> experiences = [...profile.experiences];
  late String cvFileName = profile.cvFileName;

  @override
  void dispose() {
    fullNameController.dispose();
    professionController.dispose();
    bioController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void addSkill() {
    setState(
      () => skills.add(SkillModel(title: 'New skill ${skills.length + 1}')),
    );
  }

  void addLanguage() {
    setState(
      () => languages.add(
        LanguageModel(name: 'Yangi til ${languages.length + 1}', level: 'A2'),
      ),
    );
  }

  void addExperience() {
    setState(
      () => experiences.add(
        ExperienceModel(
          position: 'Yangi lavozim',
          company: 'Kompaniya',
          period: '2025 - hozirgacha',
          description: 'Ish tajribasi haqida qisqacha ma’lumot.',
        ),
      ),
    );
  }

  void saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.primary,
        content: Text('Profil ma’lumotlari saqlandi'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        title: const Text('Profilni tahrirlash'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
        children: [
          Center(
            child: ProfileAvatarPicker(
              imageUrl: profile.imageUrl,
              verified: profile.verified,
              onTap: () =>
                  _showSnack('Profil rasmi demo rejimda almashtirildi'),
              size: 112,
            ),
          ),
          const SizedBox(height: 20),
          ProfileInfoSection(
            title: 'Asosiy ma’lumotlar',
            child: Column(
              children: [
                EditableTextField(
                  label: 'Ism familiya',
                  hint: 'To‘liq ismingiz',
                  controller: fullNameController,
                  icon: Icons.person_outline,
                ),
                EditableTextField(
                  label: 'Kasb',
                  hint: 'Masalan: Flutter Developer',
                  controller: professionController,
                  icon: Icons.work_outline,
                ),
                EditableTextField(
                  label: 'Bio',
                  hint: 'O‘zingiz haqingizda',
                  controller: bioController,
                  icon: Icons.notes_rounded,
                  maxLines: 3,
                ),
                EditableTextField(
                  label: 'Telefon',
                  hint: '+998',
                  controller: phoneController,
                  icon: Icons.phone_outlined,
                ),
                EditableTextField(
                  label: 'Manzil',
                  hint: 'Shahar, davlat',
                  controller: locationController,
                  icon: Icons.location_on_outlined,
                ),
              ],
            ),
          ),
          ProfileInfoSection(
            title: 'Ko‘nikmalar',
            action: _AddButton(onTap: addSkill),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in skills)
                  SkillChip(
                    title: skill.title,
                    onDeleted: () => setState(() => skills.remove(skill)),
                  ),
              ],
            ),
          ),
          ProfileInfoSection(
            title: 'Tillar',
            action: _AddButton(onTap: addLanguage),
            child: Column(
              children: [
                for (final language in languages)
                  LanguageTile(
                    name: language.name,
                    level: language.level,
                    onDelete: () => setState(() => languages.remove(language)),
                  ),
              ],
            ),
          ),
          ProfileInfoSection(
            title: 'Ish tajribasi',
            action: _AddButton(onTap: addExperience),
            child: Column(
              children: [
                for (final experience in experiences)
                  ExperienceTile(
                    position: experience.position,
                    company: experience.company,
                    period: experience.period,
                    description: experience.description,
                    onDelete: () =>
                        setState(() => experiences.remove(experience)),
                  ),
              ],
            ),
          ),
          ProfileInfoSection(
            title: 'Rezyume',
            child: UploadCvCard(
              fileName: cvFileName,
              onUpload: () {
                setState(() => cvFileName = 'new_workora_cv.pdf');
                _showSnack('CV demo rejimda yuklandi');
              },
            ),
          ),
          SizedBox(
            height: 58,
            child: ElevatedButton(
              onPressed: saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                'Saqlash',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: AppColors.primary, content: Text(message)),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onTap,
      style: IconButton.styleFrom(backgroundColor: AppColors.primary),
      icon: const Icon(Icons.add_rounded, color: Colors.white),
    );
  }
}
