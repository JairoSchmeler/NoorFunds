import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final VoidCallback onDeleted;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
          color: const Color(0xFF2E7D32),
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: const Color(0xFF2E7D32).withValues(alpha: 0.1),
      deleteIcon: CustomIconWidget(
        iconName: 'close',
        color: const Color(0xFF2E7D32),
        size: 16,
      ),
      onDeleted: onDeleted,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: const Color(0xFF2E7D32).withValues(alpha: 0.3),
        ),
      ),
    );
  }
}
