import 'package:flutter/material.dart';

import '../widgets/form_card.dart';
import '../widgets/input_item.dart';
import '../widgets/submit_button.dart';
import '../widgets/tip_box.dart';
import '../widgets/upload_box.dart';

class JobSeekerForm extends StatelessWidget {
  const JobSeekerForm({
    super.key,
    required this.professionController,
    required this.jobTypeController,
    required this.locationController,
    required this.salaryController,
    required this.experienceController,
    required this.skillsController,
    required this.educationController,
    required this.languageController,
    required this.aboutController,
    required this.onSubmit,
  });

  final TextEditingController professionController;
  final TextEditingController jobTypeController;
  final TextEditingController locationController;
  final TextEditingController salaryController;
  final TextEditingController experienceController;
  final TextEditingController skillsController;
  final TextEditingController educationController;
  final TextEditingController languageController;
  final TextEditingController aboutController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      icon: Icons.person_rounded,
      title: 'O‘zingiz haqingizda ma’lumot',
      subtitle: 'Ish beruvchilar siz bilan bog‘lanishi uchun ma’lumot kiriting',
      children: [
        InputItem(
          icon: Icons.work_outline_rounded,
          title: 'Lavozim / Kasb *',
          hint: 'Masalan: SMM mutaxassisi',
          controller: professionController,
        ),
        InputItem(
          icon: Icons.schedule_rounded,
          title: 'Ish turi *',
          hint: 'To‘liq stavka, Yarim stavka, Freelance',
          controller: jobTypeController,
        ),
        InputItem(
          icon: Icons.location_on_outlined,
          title: 'Ish joyi *',
          hint: 'Shahar yoki davlat',
          controller: locationController,
        ),
        InputItem(
          icon: Icons.attach_money_rounded,
          title: 'Maosh kutilgan *',
          hint: 'Masalan: 8 000 000 so‘m',
          controller: salaryController,
        ),
        InputItem(
          icon: Icons.trending_up_rounded,
          title: 'Tajriba *',
          hint: 'Masalan: 2 yil',
          controller: experienceController,
        ),
        InputItem(
          icon: Icons.star_border_rounded,
          title: 'Bilim va ko‘nikmalar *',
          hint: 'Photoshop, Word, Excel, Flutter...',
          controller: skillsController,
        ),
        InputItem(
          icon: Icons.school_outlined,
          title: 'Ta’lim *',
          hint: 'Oliy, O‘rta maxsus, Kurslar...',
          controller: educationController,
        ),
        InputItem(
          icon: Icons.language_rounded,
          title: 'Til bilish darajasi',
          hint: 'O‘zbekcha, Ruscha, Ingliz tili B1',
          controller: languageController,
        ),
        InputItem(
          icon: Icons.description_outlined,
          title: 'O‘zingiz haqingizda *',
          hint: 'Qisqacha ma’lumot yozing...',
          controller: aboutController,
          maxLines: 3,
        ),
        const UploadBox(
          title: 'Rezyume / CV yuklash',
          subtitle: 'PDF, DOCX formatda yuklang',
          button: 'Fayl tanlash',
        ),
        const TipBox(),
        SubmitButton(text: 'E’lon joylashtirish', onTap: onSubmit),
      ],
    );
  }
}
