import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdditionalFieldsWidget extends StatefulWidget {
  final TextEditingController categoryController;
  final TextEditingController notesController;
  final TextEditingController receiptNumberController;

  const AdditionalFieldsWidget({
    super.key,
    required this.categoryController,
    required this.notesController,
    required this.receiptNumberController,
  });

  @override
  State<AdditionalFieldsWidget> createState() => _AdditionalFieldsWidgetState();
}

class _AdditionalFieldsWidgetState extends State<AdditionalFieldsWidget> {
  bool _isExpanded = false;
  String _selectedCategory = '';

  final List<String> _donationCategories = [
    'Zakat',
    'Sadaqah',
    'Mosque Fund',
    'Education',
    'Healthcare',
    'Orphan Support',
    'Emergency Relief',
    'General Donation',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'add_circle_outline',
                    color: Color(0xFF2E7D32),
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Additional Information',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                  CustomIconWidget(
                    iconName: _isExpanded
                        ? 'keyboard_arrow_up'
                        : 'keyboard_arrow_down',
                    color: Color(0xFF2E7D32),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          _isExpanded ? _buildExpandedContent() : SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.3),
          ),
          SizedBox(height: 2.h),
          _buildCategoryField(),
          SizedBox(height: 2.h),
          _buildReceiptNumberField(),
          SizedBox(height: 2.h),
          _buildNotesField(),
        ],
      ),
    );
  }

  Widget _buildCategoryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donation Category',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              isExpanded: true,
              hint: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Text(
                  'Select category',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: CustomIconWidget(
                  iconName: 'keyboard_arrow_down',
                  color: Color(0xFF2E7D32),
                  size: 20,
                ),
              ),
              items: _donationCategories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      category,
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue ?? '';
                  widget.categoryController.text = _selectedCategory;
                });
              },
              dropdownColor: AppTheme.lightTheme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptNumberField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receipt Number',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.receiptNumberController,
          decoration: InputDecoration(
            hintText: 'Enter receipt number (optional)',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'receipt',
                color: Color(0xFF2E7D32),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: widget.notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any additional notes (optional)',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'note',
                color: Color(0xFF2E7D32),
                size: 20,
              ),
            ),
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
