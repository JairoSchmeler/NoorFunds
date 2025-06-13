import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class CaptureControlsWidget extends StatelessWidget {
  final VoidCallback onCapture;
  final XFile? lastCapturedImage;
  final bool isProcessing;

  const CaptureControlsWidget({
    super.key,
    required this.onCapture,
    this.lastCapturedImage,
    required this.isProcessing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Last captured image thumbnail
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: lastCapturedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://images.pexels.com/photos/6863183/pexels-photo-6863183.jpeg?auto=compress&cs=tinysrgb&w=400',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.withValues(alpha: 0.3),
                          child: CustomIconWidget(
                            iconName: 'image',
                            color: Colors.white.withValues(alpha: 0.7),
                            size: 24,
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CustomIconWidget(
                      iconName: 'photo_library',
                      color: Colors.white.withValues(alpha: 0.5),
                      size: 24,
                    ),
                  ),
          ),

          // Capture button
          GestureDetector(
            onTap: isProcessing ? null : onCapture,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isProcessing
                    ? Colors.grey.withValues(alpha: 0.5)
                    : const Color(0xFF4CAF50),
                border: Border.all(
                  color: const Color(0xFFFFD700),
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: isProcessing
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : CustomIconWidget(
                      iconName: 'camera_alt',
                      color: Colors.white,
                      size: 32,
                    ),
            ),
          ),

          // Placeholder for symmetry
          const SizedBox(width: 60),
        ],
      ),
    );
  }
}
