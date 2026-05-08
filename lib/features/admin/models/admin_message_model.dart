class AdminMessageModel {
  const AdminMessageModel({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.messages,
  });

  final String id;
  final String user;
  final String lastMessage;
  final String time;
  final int unread;
  final List<ChatLineModel> messages;

  AdminMessageModel copyWith({
    String? lastMessage,
    String? time,
    int? unread,
    List<ChatLineModel>? messages,
  }) {
    return AdminMessageModel(
      id: id,
      user: user,
      lastMessage: lastMessage ?? this.lastMessage,
      time: time ?? this.time,
      unread: unread ?? this.unread,
      messages: messages ?? this.messages,
    );
  }
}

class ChatLineModel {
  const ChatLineModel({required this.text, required this.isAdmin});

  final String text;
  final bool isAdmin;
}
