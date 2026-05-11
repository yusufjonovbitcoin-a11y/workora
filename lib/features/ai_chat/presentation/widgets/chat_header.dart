import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/design_system/app_typography.dart';
import '../../../../core/theme/app_colors.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key, this.onExit});

  final VoidCallback? onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 12.h),
      decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
      child: Row(
        children: [
          IconButton(
            onPressed: onExit,
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: AppColors.primary,
            iconSize: 20.r,
          ),
          SizedBox(width: 4.w),
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              Icons.smart_toy_rounded,
              color: AppColors.primary,
              size: 24.r,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: AppTypography.cardTitle(context),
                ),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 3.5.r,
                      backgroundColor: AppColors.primaryLight,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Onlayn',
                      style: AppTypography.caption(context).copyWith(
                        color: const Color(0xFF667085),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz_rounded),
            iconSize: 22.r,
          ),
        ],
      ),
    );
  }
}
