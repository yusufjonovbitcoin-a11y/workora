import 'package:flutter/material.dart';

/// Yuqori soyali, markazda gradient «Qo‘shish» tugmasi bo‘lgan pastki navigatsiya.
/// Ishlatiladigan indekslar: 0 — bosh, 1 — AI chat, 2 — qo‘shish, 3 — xabarlar, 4 — profil.
class PremiumNavBar extends StatelessWidget {
  const PremiumNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _activeGreen = Color(0xFF0B8F55);
  static const _inactive = Color(0xFF1C1C1C);
  static const _activeBg = Color(0xFFE8F7EF);
  static const _fabGreenTop = Color(0xFF00C26F);
  static const _fabGreenBottom = Color(0xFF008C52);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _sideItem(
                  index: 0,
                  label: 'Bosh sahifa',
                  icon: Icons.home_rounded,
                ),
              ),
              Expanded(
                child: _sideItem(
                  index: 1,
                  label: 'AI Chat',
                  icon: Icons.smart_toy_rounded,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _centerFab(),
              ),
              Expanded(
                child: _sideItem(
                  index: 3,
                  label: 'Xabarlar',
                  icon: Icons.chat_bubble_outline_rounded,
                ),
              ),
              Expanded(
                child: _sideItem(
                  index: 4,
                  label: 'Profil',
                  icon: Icons.person_outline_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sideItem({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? _activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 26,
              color: isActive ? _activeGreen : _inactive,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: isActive ? _activeGreen : _inactive,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerFab() {
    final isActive = currentIndex == 2;

    return Semantics(
      button: true,
      label: 'Qo‘shish',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(2),
        child: AnimatedScale(
          scale: isActive ? 1.04 : 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [_fabGreenTop, _fabGreenBottom],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: _fabGreenTop.withValues(alpha: 0.35),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      ),
    );
  }
}
