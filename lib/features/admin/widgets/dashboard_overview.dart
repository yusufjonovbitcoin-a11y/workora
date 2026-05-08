import 'package:flutter/material.dart';

import '../data/admin_mock_data.dart';
import '../data/analytics_mock_data.dart';
import 'admin_chart_card.dart';
import 'admin_stat_card.dart';
import 'admin_table.dart';
import 'recent_activity_card.dart';
import 'status_chip.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    const analytics = AnalyticsMockData.analytics;

    return Column(
      children: [
        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 1300 ? 5 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.75,
          children: const [
            AdminStatCard(
              title: 'Jami foydalanuvchilar',
              value: '12.856',
              icon: Icons.people_rounded,
              trend: '+256 bu hafta',
            ),
            AdminStatCard(
              title: 'Faol vakansiyalar',
              value: '1.248',
              icon: Icons.work_rounded,
              trend: '+84 bu hafta',
            ),
            AdminStatCard(
              title: 'Jami arizalar',
              value: '8.542',
              icon: Icons.assignment_rounded,
              trend: '+312 bu hafta',
            ),
            AdminStatCard(
              title: 'AI so‘rovlar',
              value: '24.856',
              icon: Icons.auto_awesome_rounded,
              trend: '+1,256 bu hafta',
            ),
            AdminStatCard(
              title: 'Platforma daromadi',
              value: '\$45.782',
              icon: Icons.paid_rounded,
              trend: '+12.5% bu oy',
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth > 900;
            final charts = [
              AdminChartCard(
                title: 'Arizalar statistikasi',
                points: analytics.userGrowth,
                type: AdminChartType.line,
              ),
              AdminChartCard(
                title: 'Foydalanuvchilar o‘sishi',
                points: analytics.applicationTrend,
                type: AdminChartType.bar,
              ),
              AdminChartCard(
                title: 'Arizalar holati',
                points: analytics.revenue,
                type: AdminChartType.pie,
              ),
            ];
            if (!wide) {
              return Column(
                children: [
                  for (final chart in charts) ...[
                    chart,
                    const SizedBox(height: 16),
                  ],
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: charts[0]),
                const SizedBox(width: 16),
                Expanded(child: charts[1]),
                const SizedBox(width: 16),
                Expanded(child: charts[2]),
              ],
            );
          },
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final latest = AdminTable(
              columns: const [
                'Vakansiya nomi',
                'Kompaniya',
                'Joylashuv',
                'Arizalar',
                'Holat',
              ],
              rows: [
                for (final vacancy in AdminMockData.vacancies)
                  [
                    Text(vacancy.title),
                    Text(vacancy.company),
                    Text(vacancy.location),
                    Text('${vacancy.applications}'),
                    StatusChip(status: vacancy.status),
                  ],
              ],
            );
            final activity = const RecentActivityCard(
              activities: AdminMockData.activities,
            );
            if (constraints.maxWidth < 900) {
              return Column(
                children: [latest, const SizedBox(height: 16), activity],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: latest),
                const SizedBox(width: 16),
                Expanded(child: activity),
              ],
            );
          },
        ),
      ],
    );
  }
}
