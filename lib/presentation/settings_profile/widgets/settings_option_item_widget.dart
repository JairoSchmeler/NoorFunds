import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class SettingsOptionItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? value;
  final VoidCallback? onTap;
  final String leadingIcon;

  const SettingsOptionItemWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.value,
    this.onTap,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF2E7D32).withAlpha(26),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: leadingIcon,
            size: 20,
            color: Color(0xFF2E7D32),
          ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.black54,
              ),
            )
          : null,
      trailing: _buildTrailing(),
      onTap: onTap,
    );
  }

  Widget _buildTrailing() {
    if (value != null) {
      return Text(
        value!,
        style: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.black54,
        ),
      );
    } else if (onTap != null) {
      return CustomIconWidget(
        iconName: 'chevron_right',
        size: 24,
        color: Colors.black45,
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
