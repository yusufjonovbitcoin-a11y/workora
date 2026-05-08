import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004D3A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 20, 28, 24),
          child: Column(
            children: [
              const Spacer(flex: 3),

              const _SplashIllustration(),

              const SizedBox(height: 40),

              const Text(
                'Workora',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                'AI yordamida ish toping',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: .58),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const Spacer(flex: 4),

              GestureDetector(
                onTap: () => context.go('/login'),
                child: Container(
                  height: 72,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00A67E), Color(0xFF007A5C)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00A67E).withValues(alpha: .28),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Boshlash',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SplashIllustration extends StatelessWidget {
  const _SplashIllustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 230,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .035),
              shape: BoxShape.circle,
            ),
          ),

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

          Positioned(
            top: 20,
            child: Container(
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
                  ...List.generate(
                    4,
                    (index) => Padding(
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
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 4,
            child: Container(
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
            ),
          ),

          Positioned(
            right: 50,
            top: 76,
            child: Transform.rotate(
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
            ),
          ),

          Positioned(
            right: 35,
            top: 150,
            child: Transform.rotate(
              angle: -0.55,
              child: Container(
                width: 16,
                height: 78,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 38,
            child: Container(
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
                        border: Border.all(
                          color: const Color(0xFF0B604D),
                          width: 8,
                        ),
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
            ),
          ),

          Positioned(
            left: 52,
            bottom: 30,
            child: Container(
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
              child: const Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),

          const Positioned(
            left: 42,
            top: 80,
            child: Text(
              '✦',
              style: TextStyle(color: Color(0xFFFFC94A), fontSize: 26),
            ),
          ),
          const Positioned(
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

class _Leaf extends StatelessWidget {
  final double size;
  final double rotation;

  const _Leaf({required this.size, required this.rotation});

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
