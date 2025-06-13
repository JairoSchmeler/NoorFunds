import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TopDonorsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> donationData;
  final String currency;

  const TopDonorsWidget({
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

  List<Map<String, dynamic>> get _topDonors {
    final sortedData = List<Map<String, dynamic>>.from(donationData);
    sortedData.sort(
        (a, b) => (b["amount"] as double).compareTo(a["amount"] as double));
    return sortedData.take(3).toList();
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
                'Top Donors',
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
          ..._topDonors.asMap().entries.map((entry) {
            final index = entry.key;
            final donor = entry.value;
            return _buildDonorItem(donor, index + 1);
          }),
        ],
      ),
    );
  }

  Widget _buildDonorItem(Map<String, dynamic> donor, int rank) {
    final rankColors = [
      Color(0xFFFFD700),
      Color(0xFFC0C0C0),
      Color(0xFFCD7F32)
    ];
    final rankColor = rank <= 3 ? rankColors[rank - 1] : Colors.grey;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: rankColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor["donorName"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  donor["category"] as String,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatCurrency(donor["amount"] as double),
                style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                _formatDate(donor["date"] as DateTime),
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
