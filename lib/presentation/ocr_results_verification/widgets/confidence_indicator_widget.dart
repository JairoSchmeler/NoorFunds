import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ConfidenceIndicatorWidget extends StatelessWidget {
  final double confidence;

  const ConfidenceIndicatorWidget({
    super.key,
    required this.confidence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.w),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: _getIconName(),
            color: _getIconColor(),
            size: 14,
          ),
          SizedBox(width: 1.w),
          Text(
            _getConfidenceText(),
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: _getTextColor(),
              fontWeight: FontWeight.w500,
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    if (confidence >= 0.9) {
      return Color(0xFF4CAF50).withValues(alpha: 0.1);
    } else if (confidence >= 0.7) {
      return Color(0xFFFFC107).withValues(alpha: 0.1);
    } else {
      return Color(0xFFF44336).withValues(alpha: 0.1);
    }
  }

  Color _getIconColor() {
    if (confidence >= 0.9) {
      return Color(0xFF4CAF50);
    } else if (confidence >= 0.7) {
      return Color(0xFFFFC107);
    } else {
      return Color(0xFFF44336);
    }
  }

  Color _getTextColor() {
    if (confidence >= 0.9) {
      return Color(0xFF2E7D32);
    } else if (confidence >= 0.7) {
      return Color(0xFFE65100);
    } else {
      return Color(0xFFD32F2F);
    }
  }

  String _getIconName() {
    if (confidence >= 0.9) {
      return 'check_circle';
    } else if (confidence >= 0.7) {
      return 'warning';
    } else {
      return 'error';
    }
  }

  String _getConfidenceText() {
    if (confidence >= 0.9) {
      return 'High';
    } else if (confidence >= 0.7) {
      return 'Medium';
    } else {
      return 'Low';
    }
  }
}
