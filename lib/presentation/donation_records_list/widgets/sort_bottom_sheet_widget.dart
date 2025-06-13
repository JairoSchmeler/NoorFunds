import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class SortBottomSheetWidget extends StatelessWidget {
  final String currentSort;
  final Function(String) onSortChanged;

  const SortBottomSheetWidget({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Sort Records',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
          ),

          Divider(height: 1),

          // Sort Options
          _buildSortOption(
            context,
            icon: 'schedule',
            title: 'Date (Newest First)',
            value: 'date_desc',
          ),
          _buildSortOption(
            context,
            icon: 'schedule',
            title: 'Date (Oldest First)',
            value: 'date_asc',
          ),
          _buildSortOption(
            context,
            icon: 'trending_up',
            title: 'Amount (High to Low)',
            value: 'amount_high',
          ),
          _buildSortOption(
            context,
            icon: 'trending_down',
            title: 'Amount (Low to High)',
            value: 'amount_low',
          ),
          _buildSortOption(
            context,
            icon: 'sort_by_alpha',
            title: 'Donor Name (A-Z)',
            value: 'name_az',
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSortOption(
    BuildContext context, {
    required String icon,
    required String title,
    required String value,
  }) {
    final isSelected = currentSort == value;

    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: isSelected ? Color(0xFF2E7D32) : Colors.grey[600]!,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? Color(0xFF2E7D32) : Colors.grey[800],
        ),
      ),
      trailing: isSelected
          ? CustomIconWidget(
              iconName: 'check',
              color: Color(0xFF2E7D32),
              size: 24,
            )
          : null,
      onTap: () {
        onSortChanged(value);
        Navigator.pop(context);
      },
    );
  }
}
