import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/conversation_model.dart';

class ConversationCard extends StatelessWidget {
  const ConversationCard({
    super.key,
    required this.conversation,
    required this.onTap,
  });

  final ConversationModel conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Row(
        children: [
          _Avatar(avatar: conversation.avatar),
          const SizedBox(width: 16),
          Expanded(child: _ConversationInfo(conversation: conversation)),
          const SizedBox(width: 12),
          _ConversationMeta(conversation: conversation),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryLight,
          child: Text(avatar, style: const TextStyle(fontSize: 28)),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConversationInfo extends StatelessWidget {
  const _ConversationInfo({required this.conversation});

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                conversation.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (conversation.verified) ...[
              const SizedBox(width: 6),
              const Icon(
                Icons.verified_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          conversation.message,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ConversationMeta extends StatelessWidget {
  const _ConversationMeta({required this.conversation});

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    final unread = conversation.unread;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          conversation.time,
          style: const TextStyle(
            color: Color(0xFF344054),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        unread.isNotEmpty
            ? Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unread,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            : Icon(
                Icons.done_all_rounded,
                color: AppColors.primary.withValues(alpha: 0.45),
              ),
      ],
    );
  }
}
