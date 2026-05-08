import 'package:flutter/material.dart';

import '../models/admin_vacancy_model.dart';
import '../widgets/admin_action_button.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_search_bar.dart';
import '../widgets/admin_table.dart';
import '../widgets/status_chip.dart';
import 'edit_vacancy_screen.dart';

class VacanciesAdminScreen extends StatefulWidget {
  const VacanciesAdminScreen({
    super.key,
    required this.vacancies,
    required this.onUpdate,
    required this.onDelete,
    required this.onAdd,
  });

  final List<AdminVacancyModel> vacancies;
  final ValueChanged<AdminVacancyModel> onUpdate;
  final ValueChanged<AdminVacancyModel> onDelete;
  final ValueChanged<AdminVacancyModel> onAdd;

  @override
  State<VacanciesAdminScreen> createState() => _VacanciesAdminScreenState();
}

class _VacanciesAdminScreenState extends State<VacanciesAdminScreen> {
  String query = '';
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.vacancies.where((item) {
      final matchesQuery =
          item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.company.toLowerCase().contains(query.toLowerCase());
      final matchesFilter = filter == 'all' || item.status == filter;
      return matchesQuery && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdminHeader(
          title: 'Vakansiyalar',
          subtitle: 'Add, edit, delete, approve va reject',
          action: AdminActionButton(
            label: 'Add vacancy',
            icon: Icons.add_rounded,
            onTap: addVacancy,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: AdminSearchBar(
                hint: 'Vakansiya qidirish...',
                onChanged: (value) => setState(() => query = value),
              ),
            ),
            const SizedBox(width: 12),
            DropdownButton<String>(
              value: filter,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('Barchasi')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'draft', child: Text('Draft')),
                DropdownMenuItem(value: 'pending', child: Text('Pending')),
              ],
              onChanged: (value) => setState(() => filter = value ?? 'all'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        AdminTable(
          columns: const ['Title', 'Company', 'Salary', 'Status', 'Actions'],
          rows: [
            for (final vacancy in filtered)
              [
                Text(vacancy.title),
                Text(vacancy.company),
                Text(vacancy.salary),
                StatusChip(status: vacancy.status),
                Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      onPressed: () => editVacancy(vacancy),
                      icon: const Icon(Icons.edit_rounded),
                    ),
                    IconButton(
                      onPressed: () =>
                          widget.onUpdate(vacancy.copyWith(status: 'active')),
                      icon: const Icon(Icons.check_circle_rounded),
                    ),
                    IconButton(
                      onPressed: () =>
                          widget.onUpdate(vacancy.copyWith(status: 'rejected')),
                      icon: const Icon(Icons.cancel_rounded),
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

  Future<void> editVacancy(AdminVacancyModel vacancy) async {
    final updated = await Navigator.of(context).push<AdminVacancyModel>(
      MaterialPageRoute(builder: (_) => EditVacancyScreen(vacancy: vacancy)),
    );
    if (updated != null) widget.onUpdate(updated);
  }

  void addVacancy() {
    widget.onAdd(
      AdminVacancyModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'New vacancy',
        company: 'Workora Partner',
        location: 'Toshkent',
        salary: 'Kelishiladi',
        status: 'draft',
        type: 'To‘liq ish vaqti',
        applications: 0,
        isForeign: false,
        country: 'Uzbekistan',
        contract: '1 yil',
        housing: 'Yo‘q',
        visa: 'Kerak emas',
        requirements: const ['Tajriba'],
        benefits: const ['Bonus'],
      ),
    );
  }
}
