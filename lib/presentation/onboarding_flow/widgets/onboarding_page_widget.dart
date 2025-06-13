import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final String iconName;
  final String illustrationUrl;
  final bool isLastPage;

  const OnboardingPageWidget({
    super.key,
    required this.title,
    required this.description,
    required this.iconName,
    required this.illustrationUrl,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            height: 240,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomImageWidget(
                    imageUrl: illustrationUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isLastPage && iconName == 'security')
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          colors: [
                            Colors.black.withAlpha(179),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'We respect your privacy',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Icon
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32).withAlpha(26),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: iconName,
                size: 36,
                color: Color(0xFF2E7D32),
              ),
            ),
          ),
          SizedBox(height: 24),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 16),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),

          // Camera permission request UI for the last page
          if (isLastPage) _buildPermissionRequest(),
        ],
      ),
    );
  }

  Widget _buildPermissionRequest() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'camera_alt',
                color: Color(0xFF2E7D32),
                size: 24,
              ),
              SizedBox(width: 12),
              Text(
                'Camera Access',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'We need camera access to scan donation receipts and extract information automatically.',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Your privacy is important to us and we adhere to Islamic ethical principles in data handling.',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
