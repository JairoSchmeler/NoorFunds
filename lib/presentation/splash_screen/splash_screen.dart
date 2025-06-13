import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _checkUserStatus();
  }

  void _initAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.65, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 0.65, curve: Curves.easeInOut),
    ));

    _animationController.forward();
  }

  Future<void> _checkUserStatus() async {
    // Simulate checking authentication status, loading app data, etc.
    // This would typically involve checking SharedPreferences, a secure storage,
    // or making API calls to validate user session
    Timer(const Duration(milliseconds: 2500), () {
      bool isFirstTimeUser = true; // This would be determined from storage

      // Navigate to appropriate screen based on user status
      if (isFirstTimeUser) {
        Navigator.pushReplacementNamed(context, '/onboarding-flow');
      } else {
        Navigator.pushReplacementNamed(context, '/dashboard-home');
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1B5E20), // Deep Islamic green
              Color(0xFF2E7D32), // Medium Islamic green
              Color(0xFF388E3C), // Lighter Islamic green
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mosque silhouette logo
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'mosque',
                    size: 80,
                    color: Color(0xFFFFD700), // Gold accent color
                  ),
                ),
              ),
              SizedBox(height: 24),

              // App name in Arabic style
              Text(
                'DonationScan',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 8),

              // Subtitle
              Text(
                'Islamic Donation Management',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withAlpha(230),
                ),
              ),

              SizedBox(height: 48),

              // Islamic star pattern loading indicator
              _buildLoadingIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD700)),
            strokeWidth: 3,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Loading...',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.white.withAlpha(204),
          ),
        ),
      ],
    );
  }
}
