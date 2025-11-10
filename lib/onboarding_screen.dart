import 'package:flutter/material.dart';
import 'package:pearltrop_rides/screens/login_screen.dart';

// This is the data model for each onboarding page
class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

// Main Onboarding Screen Widget
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // PageController helps us control which page we're on
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Define your onboarding pages here
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Book Your Ride',
      description: 'Request a ride with just a few taps and get picked up in minutes',
      icon: Icons.location_on,
      color: Color(0xFF6366F1),
    ),
    OnboardingPage(
      title: 'Track in Real-Time',
      description: 'Watch your driver arrive in real-time and know exactly when they will reach you',
      icon: Icons.navigation,
      color: Color(0xFF8B5CF6),
    ),
    OnboardingPage(
      title: 'Safe & Secure',
      description: 'All our drivers are verified and well trained',
      icon: Icons.security,
      color: Color(0xFF3B82F6),
    ),
    OnboardingPage(
      title: 'Easy Payment',
      description: 'Pay seamlessly with cash, card, or mobile wallet. No hassle!',
      icon: Icons.payment,
      color: Color(0xFF10B981),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose(); // Clean up when screen closes
    super.dispose();
  }

  // Function to go to next page
  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Last page - go to login/home screen
      _finishOnboarding();
    }
  }

  // Function to skip all pages
  void _skipOnboarding() {
    _finishOnboarding();
  }

  // Finish onboarding and navigate to next screen
 void _finishOnboarding() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage != _pages.length - 1) // Hide on last page
                    TextButton(
                      onPressed: _skipOnboarding,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // PageView - contains all the onboarding pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page indicators (dots)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),

            // Next/Get Started button at the bottom
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _pages[_currentPage].color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build individual onboarding page
  Widget _buildPage(OnboardingPage page) {
     return SingleChildScrollView(
       padding: const EdgeInsets.all(40.0),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container with animation
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 100,
              color: page.color,
            ),
          ),

          const SizedBox(height: 50),

          // Title
          Text(
            page.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // Description
          Text(
            page.description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Build page indicator dots
  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? _pages[_currentPage].color
            : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}