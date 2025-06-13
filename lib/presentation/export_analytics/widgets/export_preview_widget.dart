import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ExportPreviewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final VoidCallback onClose;

  const ExportPreviewWidget({
    super.key,
    required this.data,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Export Preview (First 10 records)',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: const Color(0xFF2E7D32),
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    const Color(0xFF2E7D32).withValues(alpha: 0.1),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Receipt',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Donor',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Category',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: data.take(10).map((item) {
                    return DataRow(
                      cells: [
                        DataCell(Text(item['receipt'] ?? '')),
                        DataCell(
                          SizedBox(
                            width: 30.w,
                            child: Text(
                              item['donor'] ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        DataCell(Text(item['amount'] ?? '')),
                        DataCell(Text(item['date'] ?? '')),
                        DataCell(
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2.w,
                              vertical: 0.5.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(item['category'] ?? ''),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item['category'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: Colors.grey.shade600,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    'This preview shows the first 10 records. The complete export will include all filtered data.',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
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

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'zakat':
        return const Color(0xFF2E7D32);
      case 'sadaqah':
        return const Color(0xFF4CAF50);
      case 'mosque fund':
        return const Color(0xFFFFD700);
      case 'education':
        return const Color(0xFF1976D2);
      case 'healthcare':
        return const Color(0xFFE91E63);
      default:
        return Colors.grey.shade600;
    }
  }
}
