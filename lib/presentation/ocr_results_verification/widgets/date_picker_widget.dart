import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final bool isHijriCalendar;
  final Function(DateTime) onDateChanged;
  final Function(bool) onCalendarToggle;

  const DatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.isHijriCalendar,
    required this.onDateChanged,
    required this.onCalendarToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _showDatePicker(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.lightTheme.dividerColor
                          .withValues(alpha: 0.5),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'calendar_today',
                        color: Color(0xFF2E7D32),
                        size: 20,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          _formatDate(selectedDate),
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomIconWidget(
                        iconName: 'keyboard_arrow_down',
                        color: Color(0xFF2E7D32),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Text(
              'Calendar Type:',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: () => onCalendarToggle(false),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                decoration: BoxDecoration(
                  color:
                      !isHijriCalendar ? Color(0xFF2E7D32) : Colors.transparent,
                  border: Border.all(
                    color: Color(0xFF2E7D32),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Gregorian',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: !isHijriCalendar ? Colors.white : Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: () => onCalendarToggle(true),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.w),
                decoration: BoxDecoration(
                  color:
                      isHijriCalendar ? Color(0xFF2E7D32) : Colors.transparent,
                  border: Border.all(
                    color: Color(0xFF2E7D32),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Hijri',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: isHijriCalendar ? Colors.white : Color(0xFF2E7D32),
                    fontWeight: FontWeight.w500,
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    if (isHijriCalendar) {
      // Mock Hijri date formatting
      return "${date.day} Rajab ${date.year + 622}";
    } else {
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    }
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Color(0xFF2E7D32),
                  onPrimary: Colors.white,
                  surface: Colors.white,
                  onSurface: Colors.black,
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onDateChanged(picked);
    }
  }
}
