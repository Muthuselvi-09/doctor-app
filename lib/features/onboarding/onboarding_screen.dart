import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/revival_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingItems = [
    OnboardingData(
      title: 'License Renewal Made Easy',
      description: 'Streamline your professional credentials and stay compliant with regulatory requirements effortlessly.',
      icon: Icons.verified_user_outlined,
    ),
    OnboardingData(
      title: 'Compliance & CME Management',
      description: 'Track your CME credits and manage compliance documents in one secure place.',
      icon: Icons.assignment_turned_in_outlined,
    ),
    OnboardingData(
      title: 'One Platform for Doctors & Hospitals',
      description: 'A unified digital ecosystem connecting doctors, clinics, and hospitals for seamless operations.',
      icon: Icons.apartment_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => context.go('/role-selection'),
            child: Text(
              'Skip',
              style: GoogleFonts.outfit(
                color: RevivalColors.navyBlue,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingItems.length,
            itemBuilder: (context, index) {
              return OnboardingItem(data: _onboardingItems[index]);
            },
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Indicators
                Row(
                  children: List.generate(
                    _onboardingItems.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 8),
                      height: 8,
                      width: _currentPage == index ? 24 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? RevivalColors.navyBlue
                            : RevivalColors.midGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                
                // Next/Get Started Button
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _onboardingItems.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      context.go('/role-selection');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RevivalColors.navyBlue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class OnboardingItem extends StatelessWidget {
  final OnboardingData data;

  const OnboardingItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: Container(
              height: 280,
              width: double.infinity,
              decoration: BoxDecoration(
                color: RevivalColors.softGrey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                data.icon,
                size: 120,
                color: RevivalColors.navyBlue,
              ),
            ),
          ),
          const SizedBox(height: 48),
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            child: Text(
              data.title,
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: RevivalColors.deepNavy,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 600),
            child: Text(
              data.description,
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: RevivalColors.darkGrey,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 80), // Space for bottom controls
        ],
      ),
    );
  }
}
