import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './confidence_indicator_widget.dart';

class ExtractedDataFormWidget extends StatelessWidget {
  final Map<String, dynamic> extractedData;
  final TextEditingController donorNameController;
  final TextEditingController donationAmountController;
  final Function(String) onFieldChanged;

  const ExtractedDataFormWidget({
    super.key,
    required this.extractedData,
    required this.donorNameController,
    required this.donationAmountController,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Extracted Information',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Color(0xFF2E7D32),
            ),
          ),
          SizedBox(height: 2.h),
          _buildDataField(
            'Donor Name',
            extractedData["donorName"]["value"],
            extractedData["donorName"]["confidence"],
            donorNameController,
            'donorName',
          ),
          SizedBox(height: 2.h),
          _buildDataField(
            'Donation Amount',
            extractedData["donationAmount"]["value"],
            extractedData["donationAmount"]["confidence"],
            donationAmountController,
            'donationAmount',
          ),
        ],
      ),
    );
  }

  Widget _buildDataField(
    String label,
    String value,
    double confidence,
    TextEditingController controller,
    String fieldKey,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 2.w),
            ConfidenceIndicatorWidget(confidence: confidence),
          ],
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          onChanged: (newValue) => onFieldChanged(fieldKey),
          decoration: InputDecoration(
            hintText: 'Enter $label',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xFF2E7D32),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
