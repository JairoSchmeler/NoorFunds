import 'package:flutter/material.dart';
import '../presentation/dashboard_home/dashboard_home.dart';
import '../presentation/ocr_camera_scan/ocr_camera_scan.dart';
import '../presentation/donation_record_detail/donation_record_detail.dart';
import '../presentation/ocr_results_verification/ocr_results_verification.dart';
import '../presentation/donation_records_list/donation_records_list.dart';
import '../presentation/export_analytics/export_analytics.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/onboarding_flow/onboarding_flow.dart';
import '../presentation/settings_profile/settings_profile.dart';

class AppRoutes {
  static const String initial = '/splash-screen';
  static const String splashScreen = '/splash-screen';
  static const String onboardingFlow = '/onboarding-flow';
  static const String dashboardHome = '/dashboard-home';
  static const String ocrCameraScan = '/ocr-camera-scan';
  static const String ocrResultsVerification = '/ocr-results-verification';
  static const String donationRecordsList = '/donation-records-list';
  static const String donationRecordDetail = '/donation-record-detail';
  static const String exportAnalytics = '/export-analytics';
  static const String settingsProfile = '/settings-profile';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    onboardingFlow: (context) => const OnboardingFlow(),
    dashboardHome: (context) => const DashboardHome(),
    ocrCameraScan: (context) => const OcrCameraScan(),
    ocrResultsVerification: (context) => const OcrResultsVerification(),
    donationRecordsList: (context) => const DonationRecordsList(),
    donationRecordDetail: (context) => const DonationRecordDetail(),
    exportAnalytics: (context) => const ExportAnalytics(),
    settingsProfile: (context) => const SettingsProfile(),
  };
}
