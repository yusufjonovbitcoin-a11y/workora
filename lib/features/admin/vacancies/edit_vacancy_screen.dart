import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/admin_vacancy_model.dart';

class EditVacancyScreen extends StatefulWidget {
  const EditVacancyScreen({super.key, required this.vacancy});

  final AdminVacancyModel vacancy;

  @override
  State<EditVacancyScreen> createState() => _EditVacancyScreenState();
}

class _EditVacancyScreenState extends State<EditVacancyScreen> {
  late final titleController = TextEditingController(
    text: widget.vacancy.title,
  );
  late final companyController = TextEditingController(
    text: widget.vacancy.company,
  );
  late final locationController = TextEditingController(
    text: widget.vacancy.location,
  );
  late final salaryController = TextEditingController(
    text: widget.vacancy.salary,
  );
  late String status = widget.vacancy.status;

  @override
  void dispose() {
    titleController.dispose();
    companyController.dispose();
    locationController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text('Vakansiyani tahrirlash')),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          _Field(label: 'Lavozim', controller: titleController),
          _Field(label: 'Kompaniya', controller: companyController),
          _Field(label: 'Manzil', controller: locationController),
          _Field(label: 'Maosh', controller: salaryController),
          DropdownButtonFormField<String>(
            initialValue: status,
            decoration: const InputDecoration(labelText: 'Status'),
            items: const [
              DropdownMenuItem(value: 'active', child: Text('Active')),
              DropdownMenuItem(value: 'draft', child: Text('Draft')),
              DropdownMenuItem(value: 'pending', child: Text('Pending')),
              DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
            ],
            onChanged: (value) => setState(() => status = value ?? status),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.vacancy.copyWith(
                    title: titleController.text,
                    company: companyController.text,
                    location: locationController.text,
                    salary: salaryController.text,
                    status: status,
                  ),
                );
              },
              child: const Text('Saqlash'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        ),
      ),
    );
  }
}
