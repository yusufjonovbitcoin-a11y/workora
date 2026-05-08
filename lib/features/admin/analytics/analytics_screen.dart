import 'package:flutter/material.dart';

import '../data/analytics_mock_data.dart';
import '../widgets/admin_chart_card.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_stat_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const analytics = AnalyticsMockData.analytics;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdminHeader(
          title: 'AI statistika',
          subtitle: 'AI requests, active users, growth va revenue',
        ),
        const SizedBox(height: 18),
        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 1100 ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.45,
          children: const [
            AdminStatCard(
              title: 'AI requests',
              value: '9.2K',
              icon: Icons.auto_awesome_rounded,
              trend: '+31%',
            ),
            AdminStatCard(
              title: 'Active users',
              value: '4.8K',
              icon: Icons.people_rounded,
              trend: '+18%',
            ),
            AdminStatCard(
              title: 'Top vacancies',
              value: '384',
              icon: Icons.work_rounded,
              trend: '+9%',
            ),
            AdminStatCard(
              title: 'Revenue',
              value: '\$24K',
              icon: Icons.payments_rounded,
              trend: '+16%',
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final charts = [
              AdminChartCard(
                title: 'User growth',
                points: analytics.userGrowth,
                type: AdminChartType.line,
              ),
              AdminChartCard(
                title: 'Applications trend',
                points: analytics.applicationTrend,
                type: AdminChartType.bar,
              ),
              AdminChartCard(
                title: 'Top countries',
                points: analytics.topCountries,
                type: AdminChartType.pie,
              ),
              AdminChartCard(
                title: 'Platform revenue',
                points: analytics.revenue,
                type: AdminChartType.pie,
              ),
            ];
            return GridView.count(
              crossAxisCount: constraints.maxWidth > 1100 ? 2 : 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: constraints.maxWidth > 1100 ? 1.9 : 1.45,
              children: charts,
            );
          },
        ),
      ],
    );
  }
}
