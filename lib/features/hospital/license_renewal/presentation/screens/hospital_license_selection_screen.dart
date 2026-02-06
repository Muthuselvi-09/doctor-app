import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/hospital/license_renewal/data/hospital_license_dummy_data.dart';
import 'package:doctor_app/features/hospital/license_renewal/domain/models/hospital_license_config.dart';
import 'package:flutter/material.dart';
import 'hospital_renewal_stepper_screen.dart';
import 'hospital_renewal_status_screen.dart';

class HospitalLicenseSelectionScreen extends StatelessWidget {
  const HospitalLicenseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: const Text(
          "Hospital License Renewal",
          style: TextStyle(color: RevivalColors.white),
        ),
        backgroundColor: RevivalColors.navyBlue,
        iconTheme: const IconThemeData(color: RevivalColors.white),
        actions: [
          IconButton(
            onPressed: () {
               // Placeholder import needed if not already present, but using dynamic routing or assuming duplicate import for now to keep it simple or I will just add import
               Navigator.push(context, MaterialPageRoute(builder: (context) => const HospitalRenewalStatusScreen()));
            }, 
            icon: const Icon(Icons.history),
            tooltip: 'Renewal Status',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select License to Renew",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: RevivalColors.navyBlue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Choose from the list of available hospital licenses below.",
              style: TextStyle(color: RevivalColors.darkGrey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: HospitalLicenseDummyData.allLicenses.length,
                separatorBuilder: (ctx, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final license = HospitalLicenseDummyData.allLicenses[index];
                  return _buildLicenseCard(context, license);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseCard(BuildContext context, HospitalLicenseConfig license) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalRenewalStepperScreen(licenseConfig: license),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: RevivalColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(license.icon, color: RevivalColors.primaryBlue, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      license.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: RevivalColors.navyBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      license.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: RevivalColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: RevivalColors.darkGrey),
            ],
          ),
        ),
      ),
    );
  }
}
