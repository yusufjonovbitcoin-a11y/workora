import 'package:flutter/material.dart';

import '../models/application_model.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_search_bar.dart';
import '../widgets/admin_table.dart';
import '../widgets/status_chip.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({
    super.key,
    required this.applications,
    required this.onStatusChanged,
  });

  final List<ApplicationModel> applications;
  final void Function(ApplicationModel application, String status)
  onStatusChanged;

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  String query = '';
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.applications.where((item) {
      final matchesQuery =
          item.applicant.toLowerCase().contains(query.toLowerCase()) ||
          item.vacancy.toLowerCase().contains(query.toLowerCase());
      final matchesFilter = filter == 'all' || item.status == filter;
      return matchesQuery && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdminHeader(
          title: 'Arizalar',
          subtitle: 'Applicant, vacancy, status va interview jarayoni',
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: AdminSearchBar(
                hint: 'Ariza qidirish...',
                onChanged: (value) => setState(() => query = value),
              ),
            ),
            const SizedBox(width: 12),
            DropdownButton<String>(
              value: filter,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('Barchasi')),
                DropdownMenuItem(value: 'sent', child: Text('Sent')),
                DropdownMenuItem(value: 'viewed', child: Text('Viewed')),
                DropdownMenuItem(value: 'interview', child: Text('Interview')),
                DropdownMenuItem(value: 'approved', child: Text('Approved')),
                DropdownMenuItem(value: 'rejected', child: Text('Rejected')),
              ],
              onChanged: (value) => setState(() => filter = value ?? 'all'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        AdminTable(
          columns: const [
            'Applicant',
            'Vacancy',
            'Company',
            'Status',
            'Action',
          ],
          rows: [
            for (final application in filtered)
              [
                Text(application.applicant),
                Text(application.vacancy),
                Text(application.company),
                StatusChip(status: application.status),
                DropdownButton<String>(
                  value: application.status,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(value: 'sent', child: Text('Sent')),
                    DropdownMenuItem(value: 'viewed', child: Text('Viewed')),
                    DropdownMenuItem(
                      value: 'interview',
                      child: Text('Interview'),
                    ),
                    DropdownMenuItem(
                      value: 'approved',
                      child: Text('Approved'),
                    ),
                    DropdownMenuItem(
                      value: 'rejected',
                      child: Text('Rejected'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      widget.onStatusChanged(application, value);
                    }
                  },
                ),
              ],
          ],
        ),
      ],
    );
  }
}
