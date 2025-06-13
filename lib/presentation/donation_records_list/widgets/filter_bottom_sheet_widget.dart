import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Function(List<String>) onFiltersApplied;

  const FilterBottomSheetWidget({
    super.key,
    required this.onFiltersApplied,
  });

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  DateTimeRange? _selectedDateRange;
  RangeValues _amountRange = RangeValues(0, 10000);
  final List<String> _selectedCategories = [];
  String _selectedCurrency = 'SAR';
  bool _isDateSectionExpanded = false;
  bool _isAmountSectionExpanded = false;
  bool _isCategorySectionExpanded = false;
  bool _isCurrencySectionExpanded = false;

  final List<String> _categories = [
    'Zakat',
    'Sadaqah',
    'Mosque Fund',
    'Orphan Support',
    'Education Fund',
    'Medical Aid',
    'Emergency Relief',
  ];

  final List<String> _currencies = ['SAR', 'USD', 'EUR', 'AED'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Text(
                  'Filter Records',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: _clearAllFilters,
                  child: Text(
                    'Clear All',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1),

          // Filter Options
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                // Date Range Filter
                _buildExpandableSection(
                  title: 'Date Range',
                  icon: 'date_range',
                  isExpanded: _isDateSectionExpanded,
                  onToggle: () => setState(
                      () => _isDateSectionExpanded = !_isDateSectionExpanded),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _selectDateRange,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFF2E7D32)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                _selectedDateRange == null
                                    ? 'Select Date Range'
                                    : '${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}',
                                style: TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          if (_selectedDateRange != null) ...[
                            SizedBox(width: 8),
                            IconButton(
                              onPressed: () =>
                                  setState(() => _selectedDateRange = null),
                              icon: CustomIconWidget(
                                iconName: 'clear',
                                color: Colors.grey[600]!,
                                size: 20,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Amount Range Filter
                _buildExpandableSection(
                  title: 'Amount Range',
                  icon: 'attach_money',
                  isExpanded: _isAmountSectionExpanded,
                  onToggle: () => setState(() =>
                      _isAmountSectionExpanded = !_isAmountSectionExpanded),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Text(
                        '${_amountRange.start.round()} - ${_amountRange.end.round()} $_selectedCurrency',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      RangeSlider(
                        values: _amountRange,
                        min: 0,
                        max: 10000,
                        divisions: 100,
                        activeColor: Color(0xFF2E7D32),
                        inactiveColor: Color(0xFF2E7D32).withValues(alpha: 0.3),
                        onChanged: (values) =>
                            setState(() => _amountRange = values),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Category Filter
                _buildExpandableSection(
                  title: 'Categories',
                  icon: 'category',
                  isExpanded: _isCategorySectionExpanded,
                  onToggle: () => setState(() =>
                      _isCategorySectionExpanded = !_isCategorySectionExpanded),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categories.map((category) {
                          final isSelected =
                              _selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(category),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategories.add(category);
                                } else {
                                  _selectedCategories.remove(category);
                                }
                              });
                            },
                            selectedColor:
                                Color(0xFF2E7D32).withValues(alpha: 0.2),
                            checkmarkColor: Color(0xFF2E7D32),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Color(0xFF2E7D32)
                                  : Colors.grey[700],
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                            side: BorderSide(
                              color: isSelected
                                  ? Color(0xFF2E7D32)
                                  : Colors.grey[400]!,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Currency Filter
                _buildExpandableSection(
                  title: 'Currency',
                  icon: 'currency_exchange',
                  isExpanded: _isCurrencySectionExpanded,
                  onToggle: () => setState(() =>
                      _isCurrencySectionExpanded = !_isCurrencySectionExpanded),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _currencies.map((currency) {
                          final isSelected = _selectedCurrency == currency;
                          return ChoiceChip(
                            label: Text(currency),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedCurrency = currency);
                              }
                            },
                            selectedColor:
                                Color(0xFF2E7D32).withValues(alpha: 0.2),
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? Color(0xFF2E7D32)
                                  : Colors.grey[700],
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                            side: BorderSide(
                              color: isSelected
                                  ? Color(0xFF2E7D32)
                                  : Colors.grey[400]!,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Apply Button
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required String icon,
    required bool isExpanded,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CustomIconWidget(
              iconName: icon,
              color: Color(0xFF2E7D32),
              size: 24,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            trailing: CustomIconWidget(
              iconName: isExpanded ? 'expand_less' : 'expand_more',
              color: Colors.grey[600]!,
              size: 24,
            ),
            onTap: onToggle,
          ),
          if (isExpanded) ...[
            Divider(height: 1),
            Padding(
              padding: EdgeInsets.all(16),
              child: child,
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Color(0xFF2E7D32),
                ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDateRange = picked);
    }
  }

  void _clearAllFilters() {
    setState(() {
      _selectedDateRange = null;
      _amountRange = RangeValues(0, 10000);
      _selectedCategories.clear();
      _selectedCurrency = 'SAR';
    });
  }

  void _applyFilters() {
    List<String> activeFilters = [];

    if (_selectedDateRange != null) {
      activeFilters.add(
          'Date: ${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}');
    }

    if (_amountRange.start > 0 || _amountRange.end < 10000) {
      activeFilters.add(
          'Amount: ${_amountRange.start.round()}-${_amountRange.end.round()} $_selectedCurrency');
    }

    if (_selectedCategories.isNotEmpty) {
      activeFilters.add('Categories: ${_selectedCategories.join(', ')}');
    }

    if (_selectedCurrency != 'SAR') {
      activeFilters.add('Currency: $_selectedCurrency');
    }

    widget.onFiltersApplied(activeFilters);
    Navigator.pop(context);
  }
}
