import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import './widgets/donation_record_card_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/sort_bottom_sheet_widget.dart';

class DonationRecordsList extends StatefulWidget {
  const DonationRecordsList({super.key});

  @override
  State<DonationRecordsList> createState() => _DonationRecordsListState();
}

class _DonationRecordsListState extends State<DonationRecordsList>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;

  List<Map<String, dynamic>> _allRecords = [];
  List<Map<String, dynamic>> _filteredRecords = [];
  List<String> _activeFilters = [];
  bool _isLoading = false;
  bool _isRefreshing = false;
  String _sortBy = 'date_desc';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _loadData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final data = await DonationService.getUserDonations();
    _allRecords = data
        .map((d) => {
              'id': d['id'],
              'donorName': d['donor_name'],
              'donorNameEn': d['donor_name'],
              'amount': d['amount'],
              'currency': d['currency'] ?? 'SAR',
              'date': DateTime.tryParse(d['date'] ?? '') ?? DateTime.now(),
              'category': d['category'] ?? 'General',
              'categoryAr': d['category'] ?? 'General',
              'notes': d['notes'] ?? '',
              'receiptNumber': d['receipt_number'] ?? '',
              'paymentMethod': d['payment_method'] ?? '',
            })
        .toList();
    _filteredRecords = List.from(_allRecords);
    _sortRecords();
    setState(() {});
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreRecords();
    }
  }

  void _loadMoreRecords() {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    // Simulate loading more records
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    HapticFeedback.lightImpact();

    await _loadData();

    if (mounted) {
      setState(() {
        _isRefreshing = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRecords = List.from(_allRecords);
      } else {
        _filteredRecords = _allRecords.where((record) {
          final donorName = (record['donorName'] as String).toLowerCase();
          final donorNameEn = (record['donorNameEn'] as String).toLowerCase();
          final searchQuery = query.toLowerCase();
          return donorName.contains(searchQuery) ||
              donorNameEn.contains(searchQuery);
        }).toList();
      }
      _sortRecords();
    });
  }

  void _sortRecords() {
    switch (_sortBy) {
      case 'date_desc':
        _filteredRecords.sort(
            (a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));
        break;
      case 'date_asc':
        _filteredRecords.sort(
            (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));
        break;
      case 'amount_high':
        _filteredRecords.sort(
            (a, b) => (b['amount'] as double).compareTo(a['amount'] as double));
        break;
      case 'amount_low':
        _filteredRecords.sort(
            (a, b) => (a['amount'] as double).compareTo(b['amount'] as double));
        break;
      case 'name_az':
        _filteredRecords.sort((a, b) =>
            (a['donorNameEn'] as String).compareTo(b['donorNameEn'] as String));
        break;
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            FilterBottomSheetWidget(onFiltersApplied: (filters) {
              setState(() {
                _activeFilters = filters;
              });
            }));
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => SortBottomSheetWidget(
            currentSort: _sortBy,
            onSortChanged: (sortBy) {
              setState(() {
                _sortBy = sortBy;
                _sortRecords();
              });
            }));
  }

  void _removeFilter(String filter) {
    setState(() {
      _activeFilters.remove(filter);
    });
  }

  void _onRecordTap(Map<String, dynamic> record) {
    Navigator.pushNamed(context, '/donation-record-detail', arguments: record);
  }

  void _onRecordEdit(Map<String, dynamic> record) {
    // Handle edit action
    HapticFeedback.selectionClick();
  }

  void _onRecordDuplicate(Map<String, dynamic> record) {
    // Handle duplicate action
    HapticFeedback.selectionClick();
  }

  void _onRecordShare(Map<String, dynamic> record) {
    // Handle share receipt action
    HapticFeedback.selectionClick();
  }

  void _onRecordDelete(Map<String, dynamic> record) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text('Delete Record'),
                content: Text(
                    'Are you sure you want to delete this donation record?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        DonationService.deleteDonation(record['id']);
                        setState(() {
                          _allRecords.removeWhere((r) => r['id'] == record['id']);
                          _filteredRecords.removeWhere((r) => r['id'] == record['id']);
                        });
                        Navigator.pop(context);
                        HapticFeedback.heavyImpact();
                      },
                      child:
                          Text('Delete', style: TextStyle(color: Colors.red))),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            elevation: 0,
            title: Text('Donation Records',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            actions: [
              IconButton(
                  onPressed: _showSortBottomSheet,
                  icon: CustomIconWidget(
                      iconName: 'sort', color: Colors.white, size: 24)),
            ]),
        body: Column(children: [
          // Search and Filter Section
          Container(
              color: Color(0xFF2E7D32),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(children: [
                // Search Bar
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(26),
                              blurRadius: 4,
                              offset: Offset(0, 2)),
                        ]),
                    child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                            hintText: 'Search by donor name...',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon: CustomIconWidget(
                                iconName: 'search',
                                color: Colors.grey[600]!,
                                size: 20),
                            suffixIcon: IconButton(
                                onPressed: _showFilterBottomSheet,
                                icon: CustomIconWidget(
                                    iconName: 'filter_list',
                                    color: Color(0xFF2E7D32),
                                    size: 20)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12)))),

                // Active Filters
                if (_activeFilters.isNotEmpty) ...[
                  SizedBox(height: 12),
                  SizedBox(
                      height: 32,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _activeFilters.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final filter = _activeFilters[index];
                            return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFD700).withAlpha(51),
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(color: Color(0xFFFFD700))),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(filter,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500)),
                                      SizedBox(width: 4),
                                      GestureDetector(
                                          onTap: () => _removeFilter(filter),
                                          child: CustomIconWidget(
                                              iconName: 'close',
                                              color: Colors.white,
                                              size: 14)),
                                    ]));
                          })),
                ],
              ])),

          // Records List
          Expanded(
              child: _filteredRecords.isEmpty
                  ? EmptyStateWidget(
                      onScanPressed: () =>
                          Navigator.pushNamed(context, '/ocr-camera-scan'))
                  : RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: Color(0xFF2E7D32),
                      child: ListView.separated(
                          controller: _scrollController,
                          padding: EdgeInsets.all(16),
                          itemCount:
                              _filteredRecords.length + (_isLoading ? 1 : 0),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            if (index >= _filteredRecords.length) {
                              return Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: CircularProgressIndicator(
                                          color: Color(0xFF2E7D32))));
                            }

                            final record = _filteredRecords[index];
                            return DonationRecordCardWidget(
                                record: record,
                                onTap: () => _onRecordTap(record),
                                onEdit: () => _onRecordEdit(record),
                                onDuplicate: () => _onRecordDuplicate(record),
                                onShare: () => _onRecordShare(record),
                                onDelete: () => _onRecordDelete(record));
                          }))),
        ]),

        // Bottom Navigation
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 8,
                  offset: Offset(0, -2)),
            ]),
            child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.grey[600],
                indicatorColor: Color(0xFF2E7D32),
                labelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                unselectedLabelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                tabs: [
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'dashboard',
                          color: _tabController.index == 0
                              ? Color(0xFF2E7D32)
                              : Colors.grey[600]!,
                          size: 24),
                      text: 'Dashboard'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'list',
                          color: _tabController.index == 1
                              ? Color(0xFF2E7D32)
                              : Colors.grey[600]!,
                          size: 24),
                      text: 'Records'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'camera_alt',
                          color: _tabController.index == 2
                              ? Color(0xFF2E7D32)
                              : Colors.grey[600]!,
                          size: 24),
                      text: 'Scan'),
                  Tab(
                      icon: CustomIconWidget(
                          iconName: 'analytics',
                          color: _tabController.index == 3
                              ? Color(0xFF2E7D32)
                              : Colors.grey[600]!,
                          size: 24),
                      text: 'Analytics'),
                ],
                onTap: (index) {
                  switch (index) {
                    case 0:
                      Navigator.pushNamed(context, '/dashboard-home');
                      break;
                    case 1:
                      // Current screen
                      break;
                    case 2:
                      Navigator.pushNamed(context, '/ocr-camera-scan');
                      break;
                    case 3:
                      Navigator.pushNamed(context, '/export-analytics');
                      break;
                  }
                })));
  }
}
