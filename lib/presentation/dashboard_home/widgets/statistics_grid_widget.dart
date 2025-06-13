import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class StatisticsGridWidget extends StatelessWidget {
  final double totalAmount;
  final int donationCount;
  final double averageAmount;
  final String currency;

  const StatisticsGridWidget({
    super.key,
    required this.totalAmount,
    required this.donationCount,
    required this.averageAmount,
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

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          'Monthly Total',
          _formatCurrency(totalAmount * 0.7), // Mock monthly data
          CustomIconWidget(
            iconName: 'calendar_month',
            color: Color(0xFF2E7D32),
            size: 24,
          ),
          Color(0xFFE8F5E8),
        ),
        _buildStatCard(
          'Total Donations',
          donationCount.toString(),
          CustomIconWidget(
            iconName: 'volunteer_activism',
            color: Color(0xFFFFD700),
            size: 24,
          ),
          Color(0xFFFFF8E1),
        ),
        _buildStatCard(
          'Average Amount',
          _formatCurrency(averageAmount),
          CustomIconWidget(
            iconName: 'trending_up',
            color: Color(0xFF4CAF50),
            size: 24,
          ),
          Color(0xFFE8F5E8),
        ),
        _buildStatCard(
          'This Week',
          _formatCurrency(totalAmount * 0.3), // Mock weekly data
          CustomIconWidget(
            iconName: 'date_range',
            color: Color(0xFFFF9800),
            size: 24,
          ),
          Color(0xFFFFF3E0),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String title, String value, Widget icon, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              icon,
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
