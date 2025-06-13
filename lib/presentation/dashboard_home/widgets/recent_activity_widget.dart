import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class RecentActivityWidget extends StatelessWidget {
  final List<Map<String, dynamic>> donationData;
  final String currency;

  const RecentActivityWidget({
    super.key,
    required this.donationData,
    required this.currency,
  });

  String _formatCurrency(double amount) {
    switch (currency) {
      case 'SAR':
        return '${amount.toStringAsFixed(2)} ر.س';
      case 'AED':
        return '${amount.toStringAsFixed(2)} د.إ';
      case 'USD':
        return '\$${amount.toStringAsFixed(2)}';
      case 'EUR':
        return '€${amount.toStringAsFixed(2)}';
      default:
        return '${amount.toStringAsFixed(2)} ر.س';
    }
  }

  List<Map<String, dynamic>> get _recentActivities {
    final sortedData = List<Map<String, dynamic>>.from(donationData);
    sortedData.sort(
        (a, b) => (b["date"] as DateTime).compareTo(a["date"] as DateTime));
    return sortedData.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/donation-records-list');
                },
                child: Text(
                  'View All',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ..._recentActivities.map((activity) => _buildActivityItem(activity)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getCategoryColor(activity["category"] as String)
                  .withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: _getCategoryIcon(activity["category"] as String),
                color: _getCategoryColor(activity["category"] as String),
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity["donorName"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      activity["category"] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color:
                            _getCategoryColor(activity["category"] as String),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '•',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      _getTimeAgo(activity["date"] as DateTime),
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            _formatCurrency(activity["amount"] as double),
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'zakat':
        return Color(0xFF2E7D32);
      case 'sadaqah':
        return Color(0xFFFFD700);
      default:
        return Color(0xFF4CAF50);
    }
  }

  String _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'zakat':
        return 'mosque';
      case 'sadaqah':
        return 'volunteer_activism';
      default:
        return 'favorite';
    }
  }

  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
