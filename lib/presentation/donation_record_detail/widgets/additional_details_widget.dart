import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class AdditionalDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> donationData;
  final bool isEditing;
  final TextEditingController receiptNumberController;

  const AdditionalDetailsWidget({
    super.key,
    required this.donationData,
    required this.isEditing,
    required this.receiptNumberController,
  });

  Widget _buildDetailRow({
    required String icon,
    required String label,
    required String value,
    Widget? customValue,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: Colors.grey[600]!,
            size: 18,
          ),
          SizedBox(width: 12),
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
                SizedBox(height: 2),
                customValue ??
                    Text(
                      value,
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableDetailRow({
    required String icon,
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: icon,
            color: Colors.grey[600]!,
            size: 18,
          ),
          SizedBox(width: 12),
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
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter $label',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
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

  String _formatDateTime(String dateTimeString) {
    try {
      final DateTime dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeString;
    }
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
                  iconName: 'info',
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Additional Details',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Receipt Number
            isEditing
                ? _buildEditableDetailRow(
                    icon: 'receipt',
                    label: 'Receipt Number',
                    controller: receiptNumberController,
                  )
                : _buildDetailRow(
                    icon: 'receipt',
                    label: 'Receipt Number',
                    value: donationData["receiptNumber"] ?? 'Not assigned',
                  ),

            SizedBox(height: 12),

            // Organization
            _buildDetailRow(
              icon: 'business',
              label: 'Organization',
              value: donationData["organizationNameEn"] ?? '',
              customValue: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donationData["organizationNameEn"] ?? '',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (donationData["organizationName"] != null)
                    Text(
                      donationData["organizationName"],
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontFamily: 'Arabic',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                ],
              ),
            ),

            SizedBox(height: 12),

            // Created At
            _buildDetailRow(
              icon: 'schedule',
              label: 'Created',
              value: _formatDateTime(donationData["createdAt"] ?? ''),
            ),

            SizedBox(height: 12),

            // Last Modified
            _buildDetailRow(
              icon: 'update',
              label: 'Last Modified',
              value: _formatDateTime(donationData["lastModified"] ?? ''),
            ),

            SizedBox(height: 16),

            // Record ID
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'fingerprint',
                    color: Colors.grey[600]!,
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Record ID: ',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      donationData["id"] ?? '',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
