import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/settings_option_item_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/settings_toggle_item_widget.dart';

class SettingsProfile extends StatefulWidget {
  const SettingsProfile({super.key});

  @override
  State<SettingsProfile> createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  // User preferences
  bool _useArabicLanguage = false;
  bool _useHijriCalendar = false;
  bool _useBiometricAuth = false;
  bool _enableNotifications = true;
  String _selectedCurrency = 'SAR';

  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Mohammed Al-Farsi',
    'email': 'mohammed@example.com',
    'organization': 'Al-Noor Charitable Foundation',
    'role': 'Administrator',
    'profileImage': null, // null means use placeholder
  };

  int _selectedTabIndex = 4; // Settings tab is selected

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });

    // Navigate based on tab selection
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard-home');
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
        // Already on settings
        break;
    }
  }

  void _toggleLanguage(bool value) {
    setState(() {
      _useArabicLanguage = value;
    });
    // In a real app, you would update the app's locale here
  }

  void _toggleCalendarSystem(bool value) {
    setState(() {
      _useHijriCalendar = value;
    });
    // In a real app, you would update the calendar system here
  }

  void _toggleBiometricAuth(bool value) {
    setState(() {
      _useBiometricAuth = value;
    });
    // In a real app, you would configure biometric auth here
  }

  void _toggleNotifications(bool value) {
    setState(() {
      _enableNotifications = value;
    });
    // In a real app, you would update notification settings here
  }

  void _showCurrencySelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCurrencyOption('SAR', 'Saudi Riyal (SAR)'),
            _buildCurrencyOption('AED', 'UAE Dirham (AED)'),
            _buildCurrencyOption('USD', 'US Dollar (USD)'),
            _buildCurrencyOption('EUR', 'Euro (EUR)'),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyOption(String value, String label) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _selectedCurrency,
      onChanged: (newValue) {
        setState(() {
          _selectedCurrency = newValue!;
        });
        Navigator.pop(context);
      },
    );
  }

  void _exportData() {
    // Show an export options dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'picture_as_pdf', color: Colors.red),
              title: Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Exporting as PDF...')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                  iconName: 'table_chart', color: Colors.green),
              title: Text('Export as Excel'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Exporting as Excel...')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(iconName: 'backup', color: Colors.blue),
              title: Text('Full Backup'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Creating full backup...')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _viewPrivacyPolicy() {
    // Navigate to privacy policy page
    // This would typically open a new screen with the privacy policy
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening Privacy Policy...')),
    );
  }

  void _replayOnboarding() {
    Navigator.pushNamed(context, '/onboarding-flow');
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About Noor Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'mosque',
              size: 48,
              color: Color(0xFF2E7D32),
            ),
            SizedBox(height: 16),
            Text(
              'Noor Funds',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Version 1.0.0'),
            SizedBox(height: 16),
            Text(
              'An Islamic donation management application for tracking and organizing charitable contributions.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              '© 2023 Noor Funds',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings & Profile',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16),
          children: [
            // Profile Header
            ProfileHeaderWidget(
              userData: _userData,
              onEditPressed: () {
                // Handle edit profile action
              },
            ),
            SizedBox(height: 24),

            // App Preferences Section
            SettingsSectionWidget(
              title: 'App Preferences',
              children: [
                SettingsToggleItemWidget(
                  title: 'Arabic Language',
                  subtitle: 'Switch between Arabic and English',
                  value: _useArabicLanguage,
                  onChanged: _toggleLanguage,
                  leadingIcon: 'language',
                ),
                SettingsToggleItemWidget(
                  title: 'Hijri Calendar',
                  subtitle: 'Use Hijri dates instead of Gregorian',
                  value: _useHijriCalendar,
                  onChanged: _toggleCalendarSystem,
                  leadingIcon: 'calendar_month',
                ),
                SettingsOptionItemWidget(
                  title: 'Currency',
                  subtitle: 'Set your preferred currency for donations',
                  value: _selectedCurrency,
                  onTap: _showCurrencySelector,
                  leadingIcon: 'attach_money',
                ),
                SettingsToggleItemWidget(
                  title: 'Notifications',
                  subtitle: 'Enable or disable app notifications',
                  value: _enableNotifications,
                  onChanged: _toggleNotifications,
                  leadingIcon: 'notifications',
                ),
              ],
            ),

            // Data Management Section
            SettingsSectionWidget(
              title: 'Data Management',
              children: [
                SettingsOptionItemWidget(
                  title: 'Export Data',
                  subtitle: 'Export your donation records',
                  onTap: _exportData,
                  leadingIcon: 'ios_share',
                ),
                SettingsOptionItemWidget(
                  title: 'Backup & Restore',
                  subtitle: 'Create backups or restore from backup',
                  onTap: () {
                    // Handle backup & restore action
                  },
                  leadingIcon: 'restore',
                ),
                SettingsOptionItemWidget(
                  title: 'Storage Usage',
                  subtitle: '24.5 MB used',
                  onTap: () {
                    // Show storage usage details
                  },
                  leadingIcon: 'storage',
                ),
              ],
            ),

            // Privacy & Security Section
            SettingsSectionWidget(
              title: 'Privacy & Security',
              children: [
                SettingsToggleItemWidget(
                  title: 'Biometric Authentication',
                  subtitle: 'Use fingerprint or face ID to login',
                  value: _useBiometricAuth,
                  onChanged: _toggleBiometricAuth,
                  leadingIcon: 'fingerprint',
                ),
                SettingsOptionItemWidget(
                  title: 'Data Encryption',
                  subtitle: 'Your data is encrypted',
                  value: 'Enabled',
                  leadingIcon: 'lock',
                ),
                SettingsOptionItemWidget(
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: _viewPrivacyPolicy,
                  leadingIcon: 'policy',
                ),
              ],
            ),

            // About Section
            SettingsSectionWidget(
              title: 'About',
              children: [
                SettingsOptionItemWidget(
                  title: 'App Version',
                  subtitle: 'Noor Funds v1.0.0',
                  onTap: _showAboutDialog,
                  leadingIcon: 'info',
                ),
                SettingsOptionItemWidget(
                  title: 'Help & Support',
                  subtitle: 'Get assistance with the app',
                  onTap: () {
                    // Handle help & support action
                  },
                  leadingIcon: 'help',
                ),
                SettingsOptionItemWidget(
                  title: 'Replay Onboarding',
                  subtitle: 'See the introduction screens again',
                  onTap: _replayOnboarding,
                  leadingIcon: 'replay',
                ),
              ],
            ),

            // Sign Out Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle sign out action
                  Navigator.pushReplacementNamed(context, '/splash-screen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Sign Out',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2E7D32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF2E7D32),
          selectedItemColor: Color(0xFFFFD700),
          unselectedItemColor: Colors.white.withAlpha(179),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          items: [
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'home',
                color: _selectedTabIndex == 0
                    ? Color(0xFFFFD700)
                    : Colors.white.withAlpha(179),
                size: 24,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'camera_alt',
                color: _selectedTabIndex == 1
                    ? Color(0xFFFFD700)
                    : Colors.white.withAlpha(179),
                size: 24,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'list',
                color: _selectedTabIndex == 2
                    ? Color(0xFFFFD700)
                    : Colors.white.withAlpha(179),
                size: 24,
              ),
              label: 'Records',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'file_download',
                color: _selectedTabIndex == 3
                    ? Color(0xFFFFD700)
                    : Colors.white.withAlpha(179),
                size: 24,
              ),
              label: 'Export',
            ),
            BottomNavigationBarItem(
              icon: CustomIconWidget(
                iconName: 'settings',
                color: _selectedTabIndex == 4
                    ? Color(0xFFFFD700)
                    : Colors.white.withAlpha(179),
                size: 24,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
