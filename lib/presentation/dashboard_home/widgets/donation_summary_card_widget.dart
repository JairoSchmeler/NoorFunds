import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class DonationSummaryCardWidget extends StatelessWidget {
  final double totalAmount;
  final String currency;
  final Function(String) onCurrencyChanged;

  const DonationSummaryCardWidget({
    super.key,
    required this.totalAmount,
    required this.currency,
    required this.onCurrencyChanged,
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFF8F9FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFFFD700),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
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
                'Total Donations',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Color(0xFF2E7D32),
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => _showCurrencySelector(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currency,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            _formatCurrency(totalAmount),
            style: AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'trending_up',
                color: Color(0xFF4CAF50),
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                'Last 30 days',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Color(0xFF4CAF50),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCurrencySelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Currency',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ...['SAR', 'AED', 'USD', 'EUR'].map((curr) {
                return ListTile(
                  leading: CustomIconWidget(
                    iconName: currency == curr
                        ? 'radio_button_checked'
                        : 'radio_button_unchecked',
                    color: currency == curr ? Color(0xFF2E7D32) : Colors.grey,
                    size: 24,
                  ),
                  title: Text(
                    _getCurrencyName(curr),
                    style: AppTheme.lightTheme.textTheme.bodyLarge,
                  ),
                  onTap: () {
                    onCurrencyChanged(curr);
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  String _getCurrencyName(String curr) {
    switch (curr) {
      case 'SAR':
        return 'Saudi Riyal (ر.س)';
      case 'AED':
        return 'UAE Dirham (د.إ)';
      case 'USD':
        return 'US Dollar (\$)';
      case 'EUR':
        return 'Euro (€)';
      default:
        return curr;
    }
  }
}
