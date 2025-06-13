import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onEditPressed;

  const ProfileHeaderWidget({
    super.key,
    required this.userData,
    required this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image
              _buildProfileImage(),
              SizedBox(width: 16),

              // User info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData['name'] ?? 'User Name',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      userData['email'] ?? 'email@example.com',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      userData['organization'] ?? 'Organization',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      userData['role'] ?? 'Role',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // Edit button
              IconButton(
                onPressed: onEditPressed,
                icon: CustomIconWidget(
                  iconName: 'edit',
                  color: Color(0xFF2E7D32),
                  size: 24,
                ),
                tooltip: 'Edit Profile',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color(0xFF2E7D32).withAlpha(26),
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFF2E7D32).withAlpha(51),
              width: 2,
            ),
          ),
          child: userData['profileImage'] != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: CustomImageWidget(
                    imageUrl: userData['profileImage'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: CustomIconWidget(
                    iconName: 'person',
                    size: 40,
                    color: Color(0xFF2E7D32),
                  ),
                ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'add_a_photo',
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
