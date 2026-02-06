import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/theme/revival_colors.dart';
import '../pharmacy_status_screen.dart';

class Step6PharmacySuccess extends StatelessWidget {
  const Step6PharmacySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified, color: RevivalColors.success, size: 80),
                ),
              ),
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  "Application Submitted!",
                  style: GoogleFonts.outfit(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    color: RevivalColors.navyBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  "Your pharmacy license renewal application has been successfully submitted to DoctorRevival. You can track the status in the portal.",
                  style: GoogleFonts.outfit(fontSize: 14, color: RevivalColors.darkGrey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PharmacyStatusScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RevivalColors.navyBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text("Track Status", style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
               FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: TextButton(
                  onPressed: () {
                     Navigator.of(context).pop(); // Ideally go back to dashboard
                  },
                  child: Text("Back to Dashboard", style: GoogleFonts.outfit(color: RevivalColors.navyBlue)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
