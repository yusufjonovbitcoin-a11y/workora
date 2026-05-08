import 'package:flutter/material.dart';

import '../models/notification_model.dart';

class NotificationsMockData {
  const NotificationsMockData._();

  static const notifications = [
    NotificationModel(
      icon: Icons.auto_awesome_rounded,
      title: 'AI sizga mos ish topdi',
      message: 'Samsung Korea vakansiyasi profilingizga 92% mos.',
      time: '5 daqiqa oldin',
      isUnread: true,
    ),
    NotificationModel(
      icon: Icons.visibility_rounded,
      title: 'Arizangiz ko‘rildi',
      message: 'Dubai Hotel Group sizning arizangizni ko‘rib chiqdi.',
      time: 'Bugun',
      isUnread: true,
    ),
    NotificationModel(
      icon: Icons.work_rounded,
      title: 'Yangi tavsiya',
      message: 'Koreya zavod ishchisi bo‘yicha yangi ishlar qo‘shildi.',
      time: 'Kecha',
      isUnread: false,
    ),
    NotificationModel(
      icon: Icons.chat_bubble_rounded,
      title: 'Yangi xabar',
      message: 'Samsung Korea HR sizga xabar yubordi.',
      time: '2 kun oldin',
      isUnread: false,
    ),
  ];
}
