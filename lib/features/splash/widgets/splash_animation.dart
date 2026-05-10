import 'package:flutter/material.dart';

class SplashAnimation extends StatelessWidget {
  const SplashAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: const [
          _BackgroundCircle(),
          Positioned(
            left: 30,
            bottom: 40,
            child: _Leaf(size: 90, rotation: -0.7),
          ),
          Positioned(
            right: 18,
            bottom: 38,
            child: _Leaf(size: 90, rotation: 0.7),
          ),
          Positioned(top: 20, child: _JobCard()),
          Positioned(top: 4, child: _Clip()),
          Positioned(right: 50, top: 76, child: _MagnifierLens()),
          Positioned(right: 35, top: 150, child: _MagnifierHandle()),
          Positioned(bottom: 38, child: _Briefcase()),
          Positioned(left: 52, bottom: 30, child: _PersonBadge()),
          Positioned(
            left: 42,
            top: 80,
            child: Text(
              '✦',
              style: TextStyle(color: Color(0xFFFFC94A), fontSize: 26),
            ),
          ),
          Positioned(
            right: 70,
            top: 70,
            child: Text(
              '✦',
              style: TextStyle(color: Color(0xFF8BE0B6), fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundCircle extends StatelessWidget {
  const _BackgroundCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 230,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .035),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Leaf extends StatelessWidget {
  const _Leaf({required this.size, required this.rotation});

  final double size;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Icon(
        Icons.eco_rounded,
        size: size,
        color: const Color(0xFF0C765E).withValues(alpha: .7),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 155,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4EA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6FB299), width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .20),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'JOB',
            style: TextStyle(
              color: Color(0xFF007A5C),
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(4, (_) => const _JobLine()),
        ],
      ),
    );
  }
}

class _JobLine extends StatelessWidget {
  const _JobLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF8ABFA8),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFB6CFC2),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Clip extends StatelessWidget {
  const _Clip();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFF1E6F5A),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 12,
            offset: const Offset(0, 7),
          ),
        ],
      ),
    );
  }
}

class _MagnifierLens extends StatelessWidget {
  const _MagnifierLens();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.55,
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: .5),
            width: 8,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .08),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _MagnifierHandle extends StatelessWidget {
  const _MagnifierHandle();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.55,
      child: Container(
        width: 16,
        height: 78,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class _Briefcase extends StatelessWidget {
  const _Briefcase();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      height: 125,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B604D), Color(0xFF003F32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1D7B65), width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .32),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -18,
            left: 76,
            child: Container(
              width: 58,
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0B604D), width: 8),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 38,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFD6B06A),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonBadge extends StatelessWidget {
  const _PersonBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0C765E), Color(0xFF03513F)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .18),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(Icons.person_rounded, color: Colors.white, size: 42),
    );
  }
}
