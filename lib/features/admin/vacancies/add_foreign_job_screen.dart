import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/admin_vacancy_model.dart';
import '../widgets/admin_action_button.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_table.dart';
import '../widgets/status_chip.dart';
import 'edit_vacancy_screen.dart';

class AddForeignJobScreen extends StatefulWidget {
  const AddForeignJobScreen({
    super.key,
    required this.vacancies,
    required this.onAdd,
    required this.onUpdate,
    required this.onDelete,
  });

  final List<AdminVacancyModel> vacancies;
  final ValueChanged<AdminVacancyModel> onAdd;
  final ValueChanged<AdminVacancyModel> onUpdate;
  final ValueChanged<AdminVacancyModel> onDelete;

  @override
  State<AddForeignJobScreen> createState() => _AddForeignJobScreenState();
}

class _AddForeignJobScreenState extends State<AddForeignJobScreen> {
  final countryController = TextEditingController(text: 'Koreya');
  final cityController = TextEditingController(text: 'Seul');
  final salaryController = TextEditingController(text: '\$2,200 - \$2,800');
  final contractController = TextEditingController(text: '3 yil');
  final housingController = TextEditingController(text: 'Yotoqxona bor');
  final visaController = TextEditingController(text: 'Viza yordami');
  final requirementsController = TextEditingController(
    text: '18-45 yosh, sog‘lom',
  );
  final benefitsController = TextEditingController(
    text: 'Uy-joy, sug‘urta, transport',
  );

  @override
  void dispose() {
    countryController.dispose();
    cityController.dispose();
    salaryController.dispose();
    contractController.dispose();
    housingController.dispose();
    visaController.dispose();
    requirementsController.dispose();
    benefitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdminHeader(
          title: 'Xorijda ish',
          subtitle: 'Foreign jobs add/edit form va boshqaruv',
          action: AdminActionButton(
            label: 'Add foreign job',
            icon: Icons.public_rounded,
            onTap: addForeignJob,
          ),
        ),
        const SizedBox(height: 18),
        _ForeignForm(
          controllers: [
            countryController,
            cityController,
            salaryController,
            contractController,
            housingController,
            visaController,
            requirementsController,
            benefitsController,
          ],
        ),
        const SizedBox(height: 18),
        AdminTable(
          columns: const ['Job', 'Country', 'Salary', 'Status', 'Actions'],
          rows: [
            for (final vacancy in widget.vacancies)
              [
                Text(vacancy.title),
                Text(vacancy.country),
                Text(vacancy.salary),
                StatusChip(status: vacancy.status),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final updated = await Navigator.of(context)
                            .push<AdminVacancyModel>(
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditVacancyScreen(vacancy: vacancy),
                              ),
                            );
                        if (updated != null) widget.onUpdate(updated);
                      },
                      icon: const Icon(Icons.edit_rounded),
                    ),
                    IconButton(
                      onPressed: () => widget.onDelete(vacancy),
                      icon: const Icon(Icons.delete_outline_rounded),
                    ),
                  ],
                ),
              ],
          ],
        ),
      ],
    );
  }

  void addForeignJob() {
    widget.onAdd(
      AdminVacancyModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '${countryController.text} — Ish dasturi',
        company: 'Workora Global',
        location: cityController.text,
        salary: salaryController.text,
        status: 'pending',
        type: 'Shartnoma',
        applications: 0,
        isForeign: true,
        country: countryController.text,
        contract: contractController.text,
        housing: housingController.text,
        visa: visaController.text,
        requirements: requirementsController.text.split(','),
        benefits: benefitsController.text.split(','),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.primary,
        content: Text('Xorijiy ish qo‘shildi'),
      ),
    );
  }
}

class _ForeignForm extends StatelessWidget {
  const _ForeignForm({required this.controllers});

  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    final labels = [
      'Country',
      'City',
      'Salary',
      'Contract',
      'Housing',
      'Visa',
      'Requirements',
      'Benefits',
    ];
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 3.2,
      children: [
        for (var i = 0; i < controllers.length; i++)
          TextField(
            controller: controllers[i],
            decoration: InputDecoration(
              labelText: labels[i],
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
      ],
    );
  }
}
