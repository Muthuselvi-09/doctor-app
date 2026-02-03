import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class ReviewLockScreen extends StatelessWidget {
  const ReviewLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Review & Confirm'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Profile Summary'),
            _buildSummaryCard(
              items: [
                'Full Name: Dr. Anya Sharma',
                'Council: Delhi Medical Council',
                'Registration: MC-12345',
                'Speciality: Cardiology',
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Verification Documents'),
            _buildSummaryCard(
              icon: Icons.description_outlined,
              items: [
                'MBBS/MD Degree • Available (Vault)',
                'Medical Council Registration • Available (Vault)',
                'Government ID Proof • Available (Vault)',
              ],
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Alert Subscriptions'),
            _buildSummaryCard(
              icon: Icons.notifications_active_outlined,
              items: [
                'Email: Active',
                'WhatsApp: Active',
                'Push: Active',
              ],
            ),
            const SizedBox(height: 48),
            _buildConsentCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: RevivalColors.darkGrey),
      ),
    );
  }

  Widget _buildSummaryCard({required List<String> items, IconData icon = Icons.person_outline_rounded}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Icon(icon, size: 14, color: RevivalColors.primaryBlue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14, color: RevivalColors.navyBlue, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildConsentCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.navyBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.gpp_good_rounded, color: RevivalColors.navyBlue, size: 28),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service Delegation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
                ),
                SizedBox(height: 8),
                Text(
                  'I consent to the Doctor Revival expert team acting on my behalf to verify and file my license renewal with the respective council.',
                  style: TextStyle(fontSize: 13, color: RevivalColors.navyBlue, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: ElevatedButton(
        onPressed: () => context.push('/revival-workflow-tracker'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Confirm & Submit to Revival', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
