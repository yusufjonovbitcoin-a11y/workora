class LanguageModel {
  const LanguageModel({required this.name, required this.level});

  final String name;
  final String level;

  Map<String, dynamic> toJson() => {'name': name, 'level': level};

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      name: json['name'] as String? ?? '',
      level: json['level'] as String? ?? '',
    );
  }
}
