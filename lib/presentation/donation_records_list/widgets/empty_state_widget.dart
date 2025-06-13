import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onScanPressed;

  const EmptyStateWidget({
    super.key,
    required this.onScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mosque Illustration
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'mosque',
                  color: Color(0xFF2E7D32),
                  size: 60,
                ),
              ),
            ),

            SizedBox(height: 24),

            // Title
            Text(
              'No Donation Records',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12),

            // Subtitle
            Text(
              'Start digitizing your donation records by scanning paper documents with your camera.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 32),

            // CTA Button
            ElevatedButton.icon(
              onPressed: onScanPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: CustomIconWidget(
                iconName: 'camera_alt',
                color: Colors.white,
                size: 24,
              ),
              label: Text(
                'Scan Your First Donation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: 16),

            // Secondary Action
            TextButton(
              onPressed: () {
                // Navigate to manual entry or help
              },
              child: Text(
                'Learn More About OCR Scanning',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
