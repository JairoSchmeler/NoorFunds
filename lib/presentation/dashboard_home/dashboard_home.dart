import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/analytics_chart_widget.dart';
import './widgets/donation_summary_card_widget.dart';
import './widgets/recent_activity_widget.dart';
import './widgets/statistics_grid_widget.dart';
import './widgets/top_donors_widget.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isHijriDate = false;
  String _selectedCurrency = 'SAR';
  late TabController _tabController;

  // Mock data for donations
  final List<Map<String, dynamic>> _donationData = [
    {
      "id": 1,
      "donorName": "Ahmed Al-Rashid",
      "amount": 500.0,
      "currency": "SAR",
      "date": DateTime.now().subtract(Duration(days: 1)),
      "category": "Zakat",
    },
    {
      "id": 2,
      "donorName": "Fatima Hassan",
      "amount": 250.0,
      "currency": "SAR",
      "date": DateTime.now().subtract(Duration(days: 2)),
      "category": "Sadaqah",
    },
    {
      "id": 3,
      "donorName": "Omar Abdullah",
      "amount": 1000.0,
      "currency": "SAR",
      "date": DateTime.now().subtract(Duration(days: 3)),
      "category": "Zakat",
    },
    {
      "id": 4,
      "donorName": "Aisha Mohamed",
      "amount": 150.0,
      "currency": "SAR",
      "date": DateTime.now().subtract(Duration(days: 5)),
      "category": "Sadaqah",
    },
    {
      "id": 5,
      "donorName": "Khalid Ibrahim",
      "amount": 750.0,
      "currency": "SAR",
      "date": DateTime.now().subtract(Duration(days: 7)),
      "category": "Zakat",
    },
  ];

  final List<Map<String, dynamic>> _chartData = [
    {"day": "Day 1", "amount": 500.0},
    {"day": "Day 2", "amount": 750.0},
    {"day": "Day 3", "amount": 1000.0},
    {"day": "Day 4", "amount": 300.0},
    {"day": "Day 5", "amount": 850.0},
    {"day": "Day 6", "amount": 600.0},
    {"day": "Day 7", "amount": 950.0},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double get _totalDonations {
    return (_donationData as List)
        .fold(0.0, (sum, donation) => sum + (donation["amount"] as double));
  }

  int get _donationCount {
    return _donationData.length;
  }

  double get _averageDonation {
    return _donationCount > 0 ? _totalDonations / _donationCount : 0.0;
  }

  String _formatCurrency(double amount) {
    switch (_selectedCurrency) {
      case 'SAR':
        return '${amount.toStringAsFixed(2)} ر.س';
      case 'AED':
        return '${amount.toStringAsFixed(2)} د.إ';
      case 'USD':
        return '\$${amount.toStringAsFixed(2)}';
      case 'EUR':
        return '€${amount.toStringAsFixed(2)}';
      default:
        return '${amount.toStringAsFixed(2)} ر.س';
    }
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    if (_isHijriDate) {
      return 'Hijri: ${now.day}/${now.month}/1446';
    } else {
      return 'Gregorian: ${now.day}/${now.month}/${now.year}';
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        Navigator.pushNamed(context, '/ocr-camera-scan');
        break;
      case 2:
        Navigator.pushNamed(context, '/donation-records-list');
        break;
      case 3:
        Navigator.pushNamed(context, '/export-analytics');
        break;
      case 4:
        // Settings - placeholder
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with greeting and date
                  _buildHeader(),
                  SizedBox(height: 24),

                  // Total donations summary card
                  DonationSummaryCardWidget(
                    totalAmount: _totalDonations,
                    currency: _selectedCurrency,
                    onCurrencyChanged: (currency) {
                      setState(() {
                        _selectedCurrency = currency;
                      });
                    },
                  ),
                  SizedBox(height: 24),

                  // Statistics grid
                  StatisticsGridWidget(
                    totalAmount: _totalDonations,
                    donationCount: _donationCount,
                    averageAmount: _averageDonation,
                    currency: _selectedCurrency,
                  ),
                  SizedBox(height: 24),

                  // Analytics chart
                  AnalyticsChartWidget(
                    chartData: _chartData,
                    currency: _selectedCurrency,
                  ),
                  SizedBox(height: 24),

                  // Top donors
                  TopDonorsWidget(
                    donationData: _donationData,
                    currency: _selectedCurrency,
                  ),
                  SizedBox(height: 24),

                  // Recent activity
                  RecentActivityWidget(
                    donationData: _donationData,
                    currency: _selectedCurrency,
                  ),
                  SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2E7D32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF2E7D32),
          selectedItemColor: Color(0xFFFFD700),
          unselectedItemColor: Colors.white.withValues(alpha: 0.7),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'home',
                color: _selectedIndex == 0
                    ? Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'camera_alt',
                color: _selectedIndex == 1
                    ? Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'list',
                color: _selectedIndex == 2
                    ? Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'file_download',
                color: _selectedIndex == 3
                    ? Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
              label: 'Export',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'settings',
                color: _selectedIndex == 4
                    ? Color(0xFFFFD700)
                    : Colors.white.withValues(alpha: 0.7),
                size: 24,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ocr-camera-scan');
        },
        backgroundColor: Color(0xFFFFD700),
        child: CustomIconWidget(
          iconName: 'camera_alt',
          color: Color(0xFF2E7D32),
          size: 28,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'السلام عليكم\nWelcome to DonationScan',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomIconWidget(
                iconName: 'mosque',
                color: Color(0xFFFFD700),
                size: 32,
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getCurrentDate(),
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isHijriDate = !_isHijriDate;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _isHijriDate ? 'Hijri' : 'Gregorian',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
