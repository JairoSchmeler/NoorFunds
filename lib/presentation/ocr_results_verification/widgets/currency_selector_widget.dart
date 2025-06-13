import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CurrencySelectorWidget extends StatelessWidget {
  final String selectedCurrency;
  final Function(String) onCurrencyChanged;

  const CurrencySelectorWidget({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  final List<Map<String, String>> _currencies = const [
    {"code": "SAR", "symbol": "﷼", "name": "Saudi Riyal"},
    {"code": "AED", "symbol": "د.إ", "name": "UAE Dirham"},
    {"code": "USD", "symbol": "\$", "name": "US Dollar"},
    {"code": "EUR", "symbol": "€", "name": "Euro"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCurrency,
          isExpanded: true,
          icon: Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: CustomIconWidget(
              iconName: 'keyboard_arrow_down',
              color: Color(0xFF2E7D32),
              size: 20,
            ),
          ),
          items: _currencies.map((currency) {
            return DropdownMenuItem<String>(
              value: currency["code"],
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  children: [
                    Text(
                      currency["symbol"]!,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        currency["code"]!,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onCurrencyChanged(newValue);
            }
          },
          dropdownColor: AppTheme.lightTheme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          menuMaxHeight: 40.h,
        ),
      ),
    );
  }
}
