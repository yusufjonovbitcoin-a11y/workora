/// `telegram_users` jadvalidagi qator (mahalliy saqlash uchun).
class TelegramUserLocal {
  TelegramUserLocal({
    required this.id,
    required this.telegramId,
    this.username,
    this.firstName,
    this.lastName,
    this.photoUrl,
    this.authUserId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final int telegramId;
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? photoUrl;
  final String? authUserId;
  final String role;
  final String createdAt;
  final String updatedAt;

  factory TelegramUserLocal.fromJson(Map<String, dynamic> json) {
    return TelegramUserLocal(
      id: json['id'] as String,
      telegramId: (json['telegram_id'] as num).toInt(),
      username: json['username'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      authUserId: json['auth_user_id'] as String?,
      role: json['role'] as String? ?? 'job_seeker',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'telegram_id': telegramId,
    'username': username,
    'first_name': firstName,
    'last_name': lastName,
    'photo_url': photoUrl,
    'auth_user_id': authUserId,
    'role': role,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
