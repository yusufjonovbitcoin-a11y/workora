class AnalyticsPoint {
  const AnalyticsPoint({required this.label, required this.value});

  final String label;
  final double value;
}

class AnalyticsModel {
  const AnalyticsModel({
    required this.userGrowth,
    required this.applicationTrend,
    required this.topCountries,
    required this.revenue,
  });

  final List<AnalyticsPoint> userGrowth;
  final List<AnalyticsPoint> applicationTrend;
  final List<AnalyticsPoint> topCountries;
  final List<AnalyticsPoint> revenue;
}
