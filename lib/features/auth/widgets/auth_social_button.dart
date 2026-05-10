import 'package:flutter/material.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
    this.iconColor,
    this.leading,
  }) : assert(
          (leading != null && icon == null && iconColor == null) ||
              (leading == null && icon != null && iconColor != null),
          'Either leading (custom logo) or icon + iconColor',
        );

  final String text;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? iconColor;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20);
    final child = Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE2E8F0)),
        borderRadius: radius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: leading ?? Icon(icon!, color: iconColor, size: 28),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF101828),
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );

    if (onTap == null) {
      return child;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: radius, onTap: onTap, child: child),
    );
  }
}
