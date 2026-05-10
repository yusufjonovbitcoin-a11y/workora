class SkillModel {
  const SkillModel({required this.title});

  final String title;

  Map<String, dynamic> toJson() => {'title': title};

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(title: json['title'] as String? ?? '');
  }
}
