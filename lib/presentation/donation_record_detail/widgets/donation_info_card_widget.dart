import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class DonationInfoCardWidget extends StatelessWidget {
  final Map<String, dynamic> donationData;
  final bool isEditing;
  final TextEditingController donorNameController;
  final TextEditingController amountController;
  final TextEditingController notesController;

  const DonationInfoCardWidget({
    super.key,
    required this.donationData,
    required this.isEditing,
    required this.donorNameController,
    required this.amountController,
    required this.notesController,
  });

  Widget _buildInfoRow({
    required String icon,
    required String label,
    required String value,
    String? arabicValue,
    Widget? customValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: Color(0xFF4CAF50),
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                customValue ??
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value,
                          style:
                              AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                          ),
                        ),
                        if (arabicValue != null) ...[
                          SizedBox(height: 2),
                          Text(
                            arabicValue,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: Colors.grey[600],
                              fontFamily: 'Arabic',
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ],
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required String icon,
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? suffix,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: Color(0xFF4CAF50),
                size: 20,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    hintText: 'Enter $label',
                    suffixText: suffix,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF4CAF50)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'receipt_long',
                  color: Color(0xFF4CAF50),
                  size: 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Donation Information',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Donor Name
            isEditing
                ? _buildEditableField(
                    icon: 'person',
                    label: 'Donor Name',
                    controller: donorNameController,
                  )
                : _buildInfoRow(
                    icon: 'person',
                    label: 'Donor Name',
                    value: donationData["donorNameEn"] ?? '',
                    arabicValue: donationData["donorName"],
                  ),

            Divider(color: Colors.grey.withValues(alpha: 0.2)),

            // Amount
            isEditing
                ? _buildEditableField(
                    icon: 'attach_money',
                    label: 'Amount',
                    controller: amountController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    suffix: donationData["currency"],
                  )
                : _buildInfoRow(
                    icon: 'attach_money',
                    label: 'Amount',
                    value:
                        '${donationData["currency"]} ${donationData["amount"]}',
                  ),

            Divider(color: Colors.grey.withValues(alpha: 0.2)),

            // Date
            _buildInfoRow(
              icon: 'calendar_today',
              label: 'Date',
              value: donationData["date"] ?? '',
              arabicValue: 'Hijri: ${donationData["hijriDate"]}',
            ),

            Divider(color: Colors.grey.withValues(alpha: 0.2)),

            // Category
            _buildInfoRow(
              icon: 'category',
              label: 'Category',
              value: donationData["categoryEn"] ?? '',
              arabicValue: donationData["category"],
              customValue: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFFFD700).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFFFFD700).withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'star',
                      color: Color(0xFFFFD700),
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      donationData["categoryEn"] ?? '',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Color(0xFFB8860B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (donationData["notes"] != null &&
                donationData["notes"].toString().isNotEmpty) ...[
              Divider(color: Colors.grey.withValues(alpha: 0.2)),

              // Notes
              isEditing
                  ? _buildEditableField(
                      icon: 'note',
                      label: 'Notes',
                      controller: notesController,
                    )
                  : _buildInfoRow(
                      icon: 'note',
                      label: 'Notes',
                      value: donationData["notesEn"] ?? '',
                      arabicValue: donationData["notes"],
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
