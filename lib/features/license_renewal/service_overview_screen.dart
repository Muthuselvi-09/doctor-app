import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class ServiceOverviewScreen extends StatelessWidget {
  const ServiceOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        backgroundColor: RevivalColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('What we do'),
                  _buildBenefitItem(
                    Icons.history_edu_rounded,
                    'Documents collected once & reused',
                    'We store your degree, registration, and IDs securely for all future renewals.',
                  ),
                  _buildBenefitItem(
                    Icons.notifications_active_outlined,
                    'Expiry tracking & reminders',
                    'Auto-tracking of your license validity with timely alerts before expiry.',
                  ),
                  _buildBenefitItem(
                    Icons.engineering_outlined,
                    'Renewal applied by our team',
                    'Our experts handle the paperwork and government portal submissions.',
                  ),
                  _buildBenefitItem(
                    Icons.verified_user_outlined,
                    'Certificate stored permanently',
                    'Access your digital certificates anytime, anywhere from your vault.',
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => context.push('/revival-master-profile'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RevivalColors.navyBlue,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Start Medical License Renewal',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'One-time setup for lifetime convenience',
                      style: TextStyle(color: RevivalColors.darkGrey, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: RevivalColors.navyBlue.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.verified_rounded, size: 60, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 24),
          const Text(
            'Medical License Renewal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: RevivalColors.navyBlue,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'We handle your renewal process from start to finish. Sit back and relax.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: RevivalColors.darkGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: RevivalColors.navyBlue,
        ),
      ),
    );
  }

  Widget _buildBenefitItem(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: RevivalColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: RevivalColors.navyBlue, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.navyBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: RevivalColors.darkGrey, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
