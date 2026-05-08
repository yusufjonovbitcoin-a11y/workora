import 'package:flutter/material.dart';

class NotificationModel {
  const NotificationModel({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
  });

  final IconData icon;
  final String title;
  final String message;
  final String time;
  final bool isUnread;
}
