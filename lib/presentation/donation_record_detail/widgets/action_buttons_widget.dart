import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';

class ActionButtonsWidget extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onGenerateReceipt;
  final VoidCallback onShare;
  final VoidCallback onEdit;
  final VoidCallback onSave;

  const ActionButtonsWidget({
    super.key,
    required this.isEditing,
    required this.onGenerateReceipt,
    required this.onShare,
    required this.onEdit,
    required this.onSave,
  });

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color foregroundColor,
    bool isExpanded = false,
  }) {
    return isExpanded
        ? SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                onPressed();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
                elevation: 2,
                shadowColor: backgroundColor.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: icon,
                    color: foregroundColor,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    label,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: foregroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onPressed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: foregroundColor,
                  elevation: 1,
                  shadowColor: backgroundColor.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: icon,
                      color: foregroundColor,
                      size: 18,
                    ),
                    SizedBox(height: 4),
                    Text(
                      label,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: foregroundColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'touch_app',
                color: Color(0xFF4CAF50),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Actions',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),

          if (isEditing) ...[
            // Save button when editing
            _buildActionButton(
              icon: 'save',
              label: 'Save Changes',
              onPressed: onSave,
              backgroundColor: Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              isExpanded: true,
            ),
          ] else ...[
            // Action buttons when not editing
            Row(
              children: [
                _buildActionButton(
                  icon: 'receipt_long',
                  label: 'Receipt',
                  onPressed: onGenerateReceipt,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF4CAF50),
                ),
                SizedBox(width: 12),
                _buildActionButton(
                  icon: 'share',
                  label: 'Share',
                  onPressed: onShare,
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF4CAF50),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildActionButton(
              icon: 'edit',
              label: 'Edit Donation',
              onPressed: onEdit,
              backgroundColor: Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              isExpanded: true,
            ),
          ],

          SizedBox(height: 16),

          // Quick navigation buttons
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Navigation',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pushNamed(
                              context, '/donation-records-list');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconWidget(
                                iconName: 'list',
                                color: Colors.grey[600]!,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'All Records',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pushNamed(context, '/export-analytics');
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomIconWidget(
                                iconName: 'analytics',
                                color: Colors.grey[600]!,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Analytics',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
