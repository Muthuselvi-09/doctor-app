import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class EPrescriptionConfirmationScreen extends StatelessWidget {
  const EPrescriptionConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: RevivalColors.activeGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified_user_rounded, size: 80, color: RevivalColors.activeGreen),
                ),
              ),
              const SizedBox(height: 48),
              FadeInUp(
                child: const Text(
                  'Enablement Confirmed',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: const Text(
                  'Your E-Prescription capabilities are now active and compliant with National Medical Council standards.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: RevivalColors.darkGrey, height: 1.5),
                ),
              ),
              const SizedBox(height: 64),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: ElevatedButton(
                  onPressed: () => context.push('/revival-doctor-dashboard'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RevivalColors.navyBlue,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Back to Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
