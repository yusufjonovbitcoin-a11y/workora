class ExperienceModel {
  const ExperienceModel({
    required this.position,
    required this.company,
    required this.period,
    required this.description,
  });

  final String position;
  final String company;
  final String period;
  final String description;

  Map<String, dynamic> toJson() => {
        'position': position,
        'company': company,
        'period': period,
        'description': description,
      };

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      position: json['position'] as String? ?? '',
      company: json['company'] as String? ?? '',
      period: json['period'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}
