class AdminUserModel {
  const AdminUserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.profession,
    required this.location,
    required this.imageUrl,
    required this.skills,
    required this.applications,
    required this.savedJobs,
    required this.aiMatch,
    required this.isActive,
    required this.isVerified,
    required this.isPremium,
  });

  final String id;
  final String name;
  final String phone;
  final String profession;
  final String location;
  final String imageUrl;
  final List<String> skills;
  final int applications;
  final int savedJobs;
  final int aiMatch;
  final bool isActive;
  final bool isVerified;
  final bool isPremium;

  AdminUserModel copyWith({bool? isActive, bool? isVerified, bool? isPremium}) {
    return AdminUserModel(
      id: id,
      name: name,
      phone: phone,
      profession: profession,
      location: location,
      imageUrl: imageUrl,
      skills: skills,
      applications: applications,
      savedJobs: savedJobs,
      aiMatch: aiMatch,
      isActive: isActive ?? this.isActive,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
    );
  }
}
