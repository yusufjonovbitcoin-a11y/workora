class ConversationModel {
  const ConversationModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.unread,
    required this.verified,
  });

  final String name;
  final String message;
  final String time;
  final String avatar;
  final String unread;
  final bool verified;
}
