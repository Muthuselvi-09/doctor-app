import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:flutter/material.dart';

class SubmissionSuccessScreen extends StatelessWidget {
  const SubmissionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: RevivalColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, size: 80, color: RevivalColors.success),
              ),
              const SizedBox(height: 32),
              const Text(
                "Submission Successful!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: RevivalColors.navyBlue,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Your license renewal application has been submitted to the DoctorRevival team. Track your status in the dashboard.",
                style: TextStyle(
                  fontSize: 14,
                  color: RevivalColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Status Tracking or Home
                    // Typically pop until home or replace with status screen
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RevivalColors.primaryBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Go to Dashboard"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
