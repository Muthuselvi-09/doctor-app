import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildSuccessIcon(),
              const SizedBox(height: 32),
              const Text(
                'Verification Approved',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: RevivalColors.navyBlue),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your renewed license is now active and stored permanently in your vault.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: RevivalColors.darkGrey, height: 1.5),
              ),
              const SizedBox(height: 48),
              _buildCertificateCard(),
              const Spacer(),
              _buildActionButtons(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: RevivalColors.activeGreen.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.verified_user_rounded, size: 60, color: RevivalColors.activeGreen),
    );
  }

  Widget _buildCertificateCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: RevivalColors.midGrey),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.badge_outlined, color: RevivalColors.navyBlue),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Medical License', style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue, fontSize: 16)),
                    Text('Valid until: Oct 2031', style: TextStyle(color: RevivalColors.darkGrey, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildSmallAction(Icons.visibility_outlined, 'View'),
              const SizedBox(width: 12),
              _buildSmallAction(Icons.file_download_outlined, 'Download', isPrimary: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallAction(IconData icon, String label, {bool isPrimary = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isPrimary ? RevivalColors.navyBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: RevivalColors.midGrey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: isPrimary ? Colors.white : RevivalColors.navyBlue),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isPrimary ? Colors.white : RevivalColors.navyBlue)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.go('/revival-doctor-dashboard'),
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Back to Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ],
    );
  }
}
