import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'admin_stat_card.dart';

class AdminTable extends StatelessWidget {
  const AdminTable({super.key, required this.columns, required this.rows});

  final List<String> columns;
  final List<List<Widget>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: adminCardDecoration(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w900,
          ),
          dataTextStyle: const TextStyle(fontWeight: FontWeight.w700),
          columns: [
            for (final column in columns) DataColumn(label: Text(column)),
          ],
          rows: [
            for (final row in rows)
              DataRow(cells: [for (final cell in row) DataCell(cell)]),
          ],
        ),
      ),
    );
  }
}
