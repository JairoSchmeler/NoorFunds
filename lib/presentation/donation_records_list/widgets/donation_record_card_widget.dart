import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/app_export.dart';

class DonationRecordCardWidget extends StatelessWidget {
  final Map<String, dynamic> record;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDuplicate;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const DonationRecordCardWidget({
    super.key,
    required this.record,
    required this.onTap,
    required this.onEdit,
    required this.onDuplicate,
    required this.onShare,
    required this.onDelete,
  });

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatAmount(double amount, String currency) {
    return "${amount.toStringAsFixed(0)} $currency";
  }

  @override
  Widget build(BuildContext context) {
    final donorName = record['donorName'] as String;
    final donorNameEn = record['donorNameEn'] as String;
    final amount = record['amount'] as double;
    final currency = record['currency'] as String;
    final date = record['date'] as DateTime;
    final category = record['category'] as String;
    final categoryAr = record['categoryAr'] as String;
    final receiptNumber = record['receiptNumber'] as String;
    final paymentMethod = record['paymentMethod'] as String;

    return Dismissible(
      key: Key(record['id'].toString()),
      background: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4CAF50),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'edit',
              color: Colors.white,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              'Edit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'delete',
              color: Colors.white,
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onEdit();
          return false;
        } else if (direction == DismissDirection.endToStart) {
          onDelete();
          return false;
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        onLongPress: () {
          HapticFeedback.mediumImpact();
          _showContextMenu(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: Color(0xFFFFD700),
                width: 4,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donorName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2),
                          Text(
                            donorNameEn,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFF2E7D32).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _formatAmount(amount, currency),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                // Details Row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'calendar_today',
                            color: Colors.grey[600]!,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            _formatDate(date),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFD700).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFFFFD700).withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Receipt and Payment Method
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'receipt',
                            color: Colors.grey[600]!,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            receiptNumber,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: paymentMethod == 'Cash'
                              ? 'money'
                              : paymentMethod == 'Credit Card'
                                  ? 'credit_card'
                                  : 'account_balance',
                          color: Colors.grey[600]!,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          paymentMethod,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            _buildContextMenuItem(
              context,
              icon: 'visibility',
              title: 'View Details',
              onTap: () {
                Navigator.pop(context);
                onTap();
              },
            ),
            _buildContextMenuItem(
              context,
              icon: 'edit',
              title: 'Edit Record',
              onTap: () {
                Navigator.pop(context);
                onEdit();
              },
            ),
            _buildContextMenuItem(
              context,
              icon: 'content_copy',
              title: 'Duplicate',
              onTap: () {
                Navigator.pop(context);
                onDuplicate();
              },
            ),
            _buildContextMenuItem(
              context,
              icon: 'receipt_long',
              title: 'Generate Receipt',
              onTap: () {
                Navigator.pop(context);
                onShare();
              },
            ),
            _buildContextMenuItem(
              context,
              icon: 'share',
              title: 'Share Receipt',
              onTap: () {
                Navigator.pop(context);
                onShare();
              },
            ),
            _buildContextMenuItem(
              context,
              icon: 'file_download',
              title: 'Add to Export',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(height: 1),
            _buildContextMenuItem(
              context,
              icon: 'delete',
              title: 'Delete Record',
              isDestructive: true,
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: isDestructive ? Colors.red : Colors.grey[700]!,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDestructive ? Colors.red : Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
