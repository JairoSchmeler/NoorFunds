import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './widgets/onboarding_page_widget.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 4;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'Welcome to DonationScan',
      'description':
          'Your complete Islamic donation management solution for organizing and tracking all charitable contributions with ease.',
      'icon': 'mosque',
      'illustration':
          'https://images.unsplash.com/photo-1584289537662-27851fd5ab5b?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Scan Receipts Instantly',
      'description':
          'Capture donation receipts with our advanced OCR technology to automatically extract and organize important information.',
      'icon': 'document_scanner',
      'illustration':
          'https://images.unsplash.com/photo-1622675363311-3e1904dc1885?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'title': 'Track Your Impact',
      'description':
          'View detailed analytics and reports of your charitable giving to understand your contributions over time.',
      'icon': 'bar_chart',
      'illustration':
          'https://images.pixabay.com/photo/2021/08/23/08/28/analysis-6567449_1280.jpg',
    },
    {
      'title': 'Privacy & Security',
      'description':
          'Your information is secure with us. We respect Islamic privacy principles and ensure your data remains confidential.',
      'icon': 'security',
      'illustration':
          'https://images.pexels.com/photos/5473298/pexels-photo-5473298.jpeg?auto=compress&cs=tinysrgb&w=1000',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _numPages - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _requestPermissions();
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _numPages - 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _requestPermissions() async {
    // This would be replaced with actual permission requests
    // using a package like permission_handler

    // After permissions are granted, navigate to the dashboard
    Navigator.pushReplacementNamed(context, '/dashboard-home');

    // Show a welcome toast
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome to DonationScan!'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF2E7D32),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button at the top
            if (_currentPage < _numPages - 1)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: _skipToEnd,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ),
                ),
              ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    title: _onboardingData[index]['title'],
                    description: _onboardingData[index]['description'],
                    iconName: _onboardingData[index]['icon'],
                    illustrationUrl: _onboardingData[index]['illustration'],
                    isLastPage: index == _numPages - 1,
                  );
                },
              ),
            ),

            // Bottom navigation
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_numPages, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentPage == index ? 16.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Color(0xFF2E7D32)
                              : Color(0xFFCCCCCC),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 24),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        _currentPage == _numPages - 1 ? 'Get Started' : 'Next',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
