import '../models/analytics_model.dart';

class AnalyticsMockData {
  const AnalyticsMockData._();

  static const analytics = AnalyticsModel(
    userGrowth: [
      AnalyticsPoint(label: 'Yan', value: 42),
      AnalyticsPoint(label: 'Fev', value: 58),
      AnalyticsPoint(label: 'Mar', value: 73),
      AnalyticsPoint(label: 'Apr', value: 96),
      AnalyticsPoint(label: 'May', value: 124),
    ],
    applicationTrend: [
      AnalyticsPoint(label: 'Dush', value: 14),
      AnalyticsPoint(label: 'Sesh', value: 24),
      AnalyticsPoint(label: 'Chor', value: 18),
      AnalyticsPoint(label: 'Pay', value: 31),
      AnalyticsPoint(label: 'Jum', value: 38),
    ],
    topCountries: [
      AnalyticsPoint(label: 'Koreya', value: 42),
      AnalyticsPoint(label: 'BAA', value: 28),
      AnalyticsPoint(label: 'Germaniya', value: 18),
      AnalyticsPoint(label: 'Turkiya', value: 12),
    ],
    revenue: [
      AnalyticsPoint(label: 'Basic', value: 32),
      AnalyticsPoint(label: 'Premium', value: 51),
      AnalyticsPoint(label: 'Employer', value: 17),
    ],
  );
}
