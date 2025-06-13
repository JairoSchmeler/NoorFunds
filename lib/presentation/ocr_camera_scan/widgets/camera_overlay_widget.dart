import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class CameraOverlayWidget extends StatelessWidget {
  final bool isDocumentDetected;
  final Animation<double> pulseAnimation;

  const CameraOverlayWidget({
    super.key,
    required this.isDocumentDetected,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulseAnimation,
      builder: (context, child) {
        return Container(
          color: Colors.black.withValues(alpha: 0.3),
          child: Stack(
            children: [
              // Document Detection Frame
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDocumentDetected
                          ? const Color(0xFF4CAF50)
                          : Colors.white.withValues(alpha: 0.7),
                      width: isDocumentDetected ? 3 : 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      // Corner indicators
                      ...List.generate(4, (index) {
                        return Positioned(
                          top: index < 2 ? 8 : null,
                          bottom: index >= 2 ? 8 : null,
                          left: index % 2 == 0 ? 8 : null,
                          right: index % 2 == 1 ? 8 : null,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isDocumentDetected
                                  ? const Color(0xFF4CAF50)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      }),

                      // Center instruction text
                      if (!isDocumentDetected)
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomIconWidget(
                                  iconName: 'document_scanner',
                                  color: Colors.white,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Position donation receipt\nwithin the frame',
                                  textAlign: TextAlign.center,
                                  style: AppTheme
                                      .lightTheme.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Document detected indicator
                      if (isDocumentDetected)
                        Center(
                          child: Transform.scale(
                            scale: pulseAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50)
                                    .withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'check_circle',
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Document detected',
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Islamic geometric pattern overlay (subtle)
              Positioned.fill(
                child: CustomPaint(
                  painter: IslamicPatternPainter(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD700).withValues(alpha: 0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw subtle Islamic geometric pattern
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = 40.0;

    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) * (3.14159 / 180);
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);

      canvas.drawCircle(Offset(x, y), 8, paint);
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
