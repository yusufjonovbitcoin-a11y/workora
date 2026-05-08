import 'package:flutter/material.dart';

import '../widgets/form_card.dart';
import '../widgets/input_item.dart';
import '../widgets/submit_button.dart';
import '../widgets/upload_box.dart';

class EmployerForm extends StatelessWidget {
  const EmployerForm({
    super.key,
    required this.vacancyTitleController,
    required this.companyController,
    required this.vacancyTypeController,
    required this.vacancyLocationController,
    required this.vacancySalaryController,
    required this.vacancyExperienceController,
    required this.vacancyAboutController,
    required this.requirementsController,
    required this.contactController,
    required this.onSubmit,
  });

  final TextEditingController vacancyTitleController;
  final TextEditingController companyController;
  final TextEditingController vacancyTypeController;
  final TextEditingController vacancyLocationController;
  final TextEditingController vacancySalaryController;
  final TextEditingController vacancyExperienceController;
  final TextEditingController vacancyAboutController;
  final TextEditingController requirementsController;
  final TextEditingController contactController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return FormCard(
      icon: Icons.work_rounded,
      title: 'Vakansiya qo‘shish',
      subtitle: 'Yangi vakansiya e’lonini joylashtiring',
      children: [
        InputItem(
          icon: Icons.business_center_outlined,
          title: 'Lavozim nomi *',
          hint: 'Masalan: Dasturchi Flutter',
          controller: vacancyTitleController,
        ),
        InputItem(
          icon: Icons.apartment_rounded,
          title: 'Kompaniya nomi *',
          hint: 'Kompaniya yoki tashkilot nomi',
          controller: companyController,
        ),
        InputItem(
          icon: Icons.schedule_rounded,
          title: 'Ish turi *',
          hint: 'To‘liq stavka, Yarim stavka, Freelance',
          controller: vacancyTypeController,
        ),
        InputItem(
          icon: Icons.location_on_outlined,
          title: 'Ish joyi *',
          hint: 'Shahar yoki davlat',
          controller: vacancyLocationController,
        ),
        InputItem(
          icon: Icons.attach_money_rounded,
          title: 'Maosh *',
          hint: 'Masalan: 8 000 000 so‘m',
          controller: vacancySalaryController,
        ),
        InputItem(
          icon: Icons.trending_up_rounded,
          title: 'Tajriba',
          hint: 'Masalan: 1-3 yil',
          controller: vacancyExperienceController,
        ),
        InputItem(
          icon: Icons.description_outlined,
          title: 'Ish haqida ma’lumot *',
          hint: 'Vakansiya haqida batafsil yozing...',
          controller: vacancyAboutController,
          maxLines: 3,
        ),
        InputItem(
          icon: Icons.fact_check_outlined,
          title: 'Talablar',
          hint: 'Kerakli ko‘nikmalar va talablar...',
          controller: requirementsController,
          maxLines: 3,
        ),
        InputItem(
          icon: Icons.phone_outlined,
          title: 'Aloqa ma’lumotlari *',
          hint: 'Telefon, Telegram yoki Email',
          controller: contactController,
        ),
        const UploadBox(
          title: 'Rasm qo‘shish',
          subtitle: 'Kompaniya logotipi yoki ish joyi rasmini qo‘shing',
          button: 'Rasm tanlash',
        ),
        SubmitButton(text: 'Vakansiyani joylashtirish', onTap: onSubmit),
      ],
    );
  }
}
