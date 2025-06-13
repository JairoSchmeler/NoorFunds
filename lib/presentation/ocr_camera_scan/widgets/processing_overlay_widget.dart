import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ProcessingOverlayWidget extends StatefulWidget {
  const ProcessingOverlayWidget({super.key});

  @override
  State<ProcessingOverlayWidget> createState() =>
      _ProcessingOverlayWidgetState();
}

class _ProcessingOverlayWidgetState extends State<ProcessingOverlayWidget>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Islamic geometric spinner
            AnimatedBuilder(
              animation:
                  Listenable.merge([_rotationAnimation, _pulseAnimation]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4CAF50),
                          width: 3,
                        ),
                      ),
                      child: CustomPaint(
                        painter: IslamicSpinnerPainter(),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Processing text
            Text(
              'Extracting donation data...',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Please wait while we process your document',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),

            const SizedBox(height: 32),

            // Progress indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final delay = index * 0.3;
                    final animationValue =
                        (_pulseController.value + delay) % 1.0;
                    final opacity = animationValue < 0.5
                        ? animationValue * 2
                        : (1.0 - animationValue) * 2;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            const Color(0xFFFFD700).withValues(alpha: opacity),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class IslamicSpinnerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    // Draw Islamic star pattern
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (3.14159 / 180);
      final x1 = center.dx + radius * 0.5 * cos(angle);
      final y1 = center.dy + radius * 0.5 * sin(angle);
      final x2 = center.dx + radius * cos(angle);
      final y2 = center.dy + radius * sin(angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

double cos(double radians) => radians.cos();
double sin(double radians) => radians.sin();

extension on double {
  double cos() {
    // Simple approximation for cos function
    return 1 - (this * this) / 2 + (this * this * this * this) / 24;
  }

  double sin() {
    // Simple approximation for sin function
    return this -
        (this * this * this) / 6 +
        (this * this * this * this * this) / 120;
  }
}
