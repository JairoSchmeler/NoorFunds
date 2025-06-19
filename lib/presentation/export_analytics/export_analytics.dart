import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/export_service.dart';
import '../../services/receipt_repository.dart';
import './widgets/analytics_chart_widget.dart';
import './widgets/export_preview_widget.dart';
import './widgets/filter_chip_widget.dart';
import './widgets/summary_card_widget.dart';

class ExportAnalytics extends StatefulWidget {
  const ExportAnalytics({super.key});

  @override
  State<ExportAnalytics> createState() => _ExportAnalyticsState();
}

class _ExportAnalyticsState extends State<ExportAnalytics>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  bool _isExporting = false;
  bool _showPreview = false;
  String _selectedCalendar = 'Gregorian';
  DateTimeRange? _selectedDateRange;
  final List<String> _selectedDonors = [];
  RangeValues _amountRange = const RangeValues(0, 10000);
  final List<String> _selectedCategories = [];
  bool _isFilterExpanded = false;
  final ExportService _exportService = ExportService();

  // Mock data
  final List<Map<String, dynamic>> _mockDonationData = [
    {
      "id": 1,
      "donor": "Ahmed Al-Rashid",
      "amount": "\$500.00",
      "date": "2024-01-15",
      "category": "Zakat",
      "receipt": "ZK001",
    },
    {
      "id": 2,
      "donor": "Fatima Hassan",
      "amount": "\$250.00",
      "date": "2024-01-14",
      "category": "Sadaqah",
      "receipt": "SD002",
    },
    {
      "id": 3,
      "donor": "Omar Abdullah",
      "amount": "\$1000.00",
      "date": "2024-01-13",
      "category": "Mosque Fund",
      "receipt": "MF003",
    },
    {
      "id": 4,
      "donor": "Aisha Mohamed",
      "amount": "\$150.00",
      "date": "2024-01-12",
      "category": "Education",
      "receipt": "ED004",
    },
    {
      "id": 5,
      "donor": "Hassan Ali",
      "amount": "\$300.00",
      "date": "2024-01-11",
      "category": "Healthcare",
      "receipt": "HC005",
    },
  ];

  final List<String> _availableDonors = [
    "Ahmed Al-Rashid",
    "Fatima Hassan",
    "Omar Abdullah",
    "Aisha Mohamed",
    "Hassan Ali",
    "Khalid Ibrahim",
    "Mariam Yusuf",
    "Abdullah Rahman"
  ];

  final List<String> _availableCategories = [
    "Zakat",
    "Sadaqah",
    "Mosque Fund",
    "Education",
    "Healthcare",
    "Orphan Support",
    "Emergency Relief"
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: Text(
          'Export & Analytics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: Colors.white,
            size: 24,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFFD700),
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
          labelStyle: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(text: 'Export'),
            Tab(text: 'Analytics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExportTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  Widget _buildExportTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterSection(),
          SizedBox(height: 3.h),
          _buildSelectedFiltersChips(),
          SizedBox(height: 3.h),
          _buildExportActions(),
          if (_showPreview) ...[
            SizedBox(height: 3.h),
            ExportPreviewWidget(
              data: _mockDonationData,
              onClose: () => setState(() => _showPreview = false),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryCards(),
          SizedBox(height: 3.h),
          _buildChartsSection(),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        initiallyExpanded: _isFilterExpanded,
        onExpansionChanged: (expanded) {
          setState(() => _isFilterExpanded = expanded);
        },
        leading: CustomIconWidget(
          iconName: 'filter_list',
          color: const Color(0xFF2E7D32),
          size: 24,
        ),
        title: Text(
          'Filter Options',
          style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2E7D32),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCalendarSelector(),
                SizedBox(height: 2.h),
                _buildDateRangePicker(),
                SizedBox(height: 2.h),
                _buildDonorSelector(),
                SizedBox(height: 2.h),
                _buildAmountRangeSlider(),
                SizedBox(height: 2.h),
                _buildCategorySelector(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calendar Type',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Gregorian'),
                value: 'Gregorian',
                groupValue: _selectedCalendar,
                onChanged: (value) {
                  setState(() => _selectedCalendar = value!);
                },
                activeColor: const Color(0xFF2E7D32),
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text('Hijri'),
                value: 'Hijri',
                groupValue: _selectedCalendar,
                onChanged: (value) {
                  setState(() => _selectedCalendar = value!);
                },
                activeColor: const Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRangePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date Range',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        InkWell(
          onTap: _selectDateRange,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'date_range',
                  color: const Color(0xFF2E7D32),
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    _selectedDateRange != null
                        ? '${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}'
                        : 'Select date range',
                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                  ),
                ),
                CustomIconWidget(
                  iconName: 'arrow_drop_down',
                  color: Colors.grey.shade600,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDonorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Donors (${_selectedDonors.length} selected)',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Container(
          height: 20.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: _availableDonors.length,
            itemBuilder: (context, index) {
              final donor = _availableDonors[index];
              final isSelected = _selectedDonors.contains(donor);
              return CheckboxListTile(
                title: Text(donor),
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedDonors.add(donor);
                    } else {
                      _selectedDonors.remove(donor);
                    }
                  });
                },
                activeColor: const Color(0xFF2E7D32),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAmountRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount Range (\$${_amountRange.start.round()} - \$${_amountRange.end.round()})',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        RangeSlider(
          values: _amountRange,
          min: 0,
          max: 10000,
          divisions: 100,
          labels: RangeLabels(
            '\$${_amountRange.start.round()}',
            '\$${_amountRange.end.round()}',
          ),
          onChanged: (values) {
            setState(() => _amountRange = values);
          },
          activeColor: const Color(0xFF2E7D32),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories (${_selectedCategories.length} selected)',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _availableCategories.map((category) {
            final isSelected = _selectedCategories.contains(category);
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
              selectedColor: const Color(0xFF2E7D32).withValues(alpha: 0.2),
              checkmarkColor: const Color(0xFF2E7D32),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelectedFiltersChips() {
    final List<Widget> chips = [];

    if (_selectedDateRange != null) {
      chips.add(FilterChipWidget(
        label:
            '${_formatDate(_selectedDateRange!.start)} - ${_formatDate(_selectedDateRange!.end)}',
        onDeleted: () => setState(() => _selectedDateRange = null),
      ));
    }

    if (_selectedDonors.isNotEmpty) {
      chips.add(FilterChipWidget(
        label: '${_selectedDonors.length} Donors',
        onDeleted: () => setState(() => _selectedDonors.clear()),
      ));
    }

    if (_selectedCategories.isNotEmpty) {
      chips.add(FilterChipWidget(
        label: '${_selectedCategories.length} Categories',
        onDeleted: () => setState(() => _selectedCategories.clear()),
      ));
    }

    if (_amountRange.start > 0 || _amountRange.end < 10000) {
      chips.add(FilterChipWidget(
        label: '\$${_amountRange.start.round()}-\$${_amountRange.end.round()}',
        onDeleted: () =>
            setState(() => _amountRange = const RangeValues(0, 10000)),
      ));
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Filters',
          style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: chips,
        ),
      ],
    );
  }

  Widget _buildExportActions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => setState(() => _showPreview = !_showPreview),
            icon: CustomIconWidget(
              iconName: 'preview',
              color: const Color(0xFF2E7D32),
              size: 20,
            ),
            label: Text(_showPreview ? 'Hide Preview' : 'Preview Export'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF2E7D32),
              side: const BorderSide(color: Color(0xFF2E7D32)),
              padding: EdgeInsets.symmetric(vertical: 2.h),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isExporting ? null : _generateExcel,
            icon: _isExporting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : CustomIconWidget(
                    iconName: 'file_download',
                    color: Colors.white,
                    size: 20,
                  ),
            label: Text(_isExporting ? 'Generating...' : 'Generate Excel'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              textStyle: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isExporting ? null : _downloadCsv,
            icon: _isExporting
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : CustomIconWidget(
                    iconName: 'file_download',
                    color: Colors.white,
                    size: 20,
                  ),
            label: const Text('Download Donations'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              textStyle: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Summary',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Expanded(
              child: SummaryCardWidget(
                title: 'Total Donations',
                value: '\$2,200',
                icon: 'attach_money',
                color: const Color(0xFF2E7D32),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: SummaryCardWidget(
                title: 'Average Amount',
                value: '\$440',
                icon: 'trending_up',
                color: const Color(0xFFFFD700),
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            Expanded(
              child: SummaryCardWidget(
                title: 'Top Donor',
                value: 'Omar Abdullah',
                icon: 'person',
                color: const Color(0xFF4CAF50),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: SummaryCardWidget(
                title: 'Growth',
                value: '+15.2%',
                icon: 'show_chart',
                color: const Color(0xFFFFC107),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChartsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics',
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2E7D32),
          ),
        ),
        SizedBox(height: 2.h),
        AnalyticsChartWidget(
          title: 'Monthly Donation Trends',
          chartType: 'line',
        ),
        SizedBox(height: 3.h),
        AnalyticsChartWidget(
          title: 'Donation Categories',
          chartType: 'pie',
        ),
        SizedBox(height: 3.h),
        AnalyticsChartWidget(
          title: 'Top Donors',
          chartType: 'bar',
        ),
      ],
    );
  }

  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF2E7D32),
                  onPrimary: Colors.white,
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _generateExcel() async {
    setState(() => _isExporting = true);

    // Simulate export process
    await Future.delayed(const Duration(seconds: 3));

    setState(() => _isExporting = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Excel file generated successfully!'),
          backgroundColor: const Color(0xFF2E7D32),
          action: SnackBarAction(
            label: 'Share',
            textColor: const Color(0xFFFFD700),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ),
      );
    }
  }

  void _downloadCsv() async {
    setState(() => _isExporting = true);
    try {
      final file = await _exportService
          .exportReceiptsToCsv(ReceiptRepository.instance.receipts);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV saved to ${file.path}'),
          backgroundColor: const Color(0xFF2E7D32),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }
}
