import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../auth/services/telegram_auth_service.dart';
import 'data/profile_mock_data.dart';
import 'models/experience_model.dart';
import 'models/language_model.dart';
import 'models/profile_record.dart';
import 'models/skill_model.dart';
import 'presentation/profile_providers.dart';
import 'widgets/editable_text_field.dart';
import 'widgets/experience_tile.dart';
import 'widgets/language_tile.dart';
import 'widgets/profile_avatar_picker.dart';
import 'widgets/profile_info_section.dart';
import 'widgets/skill_chip.dart';
import 'widgets/upload_cv_card.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
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

  String? _avatarUrl;
  bool _loadingInitial = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadFromSupabase());
  }

  void _applyProfileFromRecord(ProfileRecord p) {
    fullNameController.text = p.fullName;
    professionController.text = p.profession;
    bioController.text = p.bio;
    phoneController.text = p.phone;
    locationController.text = p.location;
    _avatarUrl = p.avatarUrl;
    cvFileName = p.cvFileName;
    skills
      ..clear()
      ..addAll(p.skills);
    languages
      ..clear()
      ..addAll(p.languages);
    experiences
      ..clear()
      ..addAll(p.experiences);
  }

  Future<void> _loadFromSupabase() async {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    final repo = ref.read(supabaseProfileRepositoryProvider);

    try {
      if (uid != null) {
        final p = await repo.fetchCurrentProfile();
        if (!mounted) return;
        setState(() {
          if (p != null) {
            _applyProfileFromRecord(p);
          } else {
            skills.clear();
            languages.clear();
            experiences.clear();
            fullNameController.clear();
            professionController.clear();
            bioController.clear();
            phoneController.clear();
            locationController.clear();
            cvFileName = '';
          }
        });
      } else {
        final tg = await TelegramAuthService.readLocalTelegramUser();
        if (!mounted) return;

        if (tg != null) {
          try {
            final p = await repo.fetchTelegramProfile(tg.telegramId);
            if (!mounted) return;
            setState(() {
              if (p != null) {
                _applyProfileFromRecord(p);
              } else {
                skills.clear();
                languages.clear();
                experiences.clear();
                fullNameController.clear();
                professionController.clear();
                bioController.clear();
                phoneController.clear();
                locationController.clear();
                cvFileName = '';
              }
              final parts = [tg.firstName, tg.lastName]
                  .where((x) => (x ?? '').trim().isNotEmpty)
                  .map((x) => x!.trim())
                  .toList();
              if (fullNameController.text.trim().isEmpty &&
                  parts.isNotEmpty) {
                fullNameController.text = parts.join(' ');
              }
              if ((_avatarUrl ?? '').isEmpty &&
                  (tg.photoUrl ?? '').isNotEmpty) {
                _avatarUrl = tg.photoUrl;
              }
            });
          } catch (_) {
            if (mounted) {
              _showSnack(
                'Telegram profili yuklanmadi — SQL migratsiya va '
                'get-telegram-profile funksiyasini deploy qiling.',
              );
            }
          }
        }
      }
    } catch (_) {
      if (mounted) {
        _showSnack('Profilni yuklashda xato — internetni tekshiring.');
      }
    } finally {
      if (mounted) setState(() => _loadingInitial = false);
    }
  }

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

  Future<void> saveProfile() async {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    final repo = ref.read(supabaseProfileRepositoryProvider);

    setState(() => _saving = true);
    try {
      if (uid != null) {
        final record = ProfileRecord(
          userId: uid,
          fullName: fullNameController.text.trim(),
          profession: professionController.text.trim(),
          bio: bioController.text.trim(),
          phone: phoneController.text.trim(),
          location: locationController.text.trim(),
          avatarUrl: _avatarUrl,
          skills: List.from(skills),
          languages: List.from(languages),
          experiences: List.from(experiences),
          cvUrl: null,
          cvFileName: cvFileName,
        );

        await repo.upsertProfile(record);
        if (!mounted) return;
        _showSnack('Profil saqlandi');
        Navigator.pop(context);
        return;
      }

      final tg = await TelegramAuthService.readLocalTelegramUser();
      if (tg != null) {
        final record = ProfileRecord(
          userId: tg.id,
          fullName: fullNameController.text.trim(),
          profession: professionController.text.trim(),
          bio: bioController.text.trim(),
          phone: phoneController.text.trim(),
          location: locationController.text.trim(),
          avatarUrl: _avatarUrl ?? tg.photoUrl,
          skills: List.from(skills),
          languages: List.from(languages),
          experiences: List.from(experiences),
          cvUrl: null,
          cvFileName: cvFileName,
        );

        await repo.upsertTelegramProfile(
          telegramId: tg.telegramId,
          record: record,
        );
        if (!mounted) return;
        _showSnack('Profil saqlandi');
        Navigator.pop(context);
        return;
      }

      if (!mounted) return;
      _showSnack(
        'Saqlash uchun Telegram orqali kirishingiz yoki telefon OTP kerak.',
      );
    } catch (e) {
      if (mounted) _showSnack(e.toString());
    } finally {
      if (mounted) setState(() => _saving = false);
    }
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
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
            children: [
              Center(
                child: ProfileAvatarPicker(
                  imageUrl: _avatarUrl ?? profile.imageUrl,
                  verified: profile.verified,
                  onTap: () =>
                      _showSnack('Rasm URL keyinroq Storage bilan ulanadi'),
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
                        onDelete: () =>
                            setState(() => languages.remove(language)),
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
                        onDelete: () => setState(
                          () => experiences.remove(experience),
                        ),
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
                    _showSnack('CV hozircha demo; keyin Storage ulanadi');
                  },
                ),
              ),
              SizedBox(
                height: 58,
                child: ElevatedButton(
                  onPressed: (_loadingInitial || _saving) ? null : saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: _saving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Saqlash',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                ),
              ),
            ],
          ),
          if (_loadingInitial)
            const Positioned.fill(
              child: ColoredBox(
                color: Color(0x33FFFFFF),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
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
