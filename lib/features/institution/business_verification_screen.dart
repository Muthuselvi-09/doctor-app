import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class BusinessVerificationScreen extends StatelessWidget {
  final String businessType; // 'Pharmacy' or 'Laboratory'

  const BusinessVerificationScreen({super.key, required this.businessType});

  @override
  Widget build(BuildContext context) {
    final isPharmacy = businessType == 'Pharmacy';

    final List<Map<String, dynamic>> regDocs = isPharmacy
        ? [
            {'title': 'Drug License (Retail/Wholesale)', 'icon': Icons.medical_information_rounded},
            {'title': 'Pharmacist Registration', 'icon': Icons.person_pin_rounded},
            {'title': 'GST & Tax Registration', 'icon': Icons.receipt_long_rounded},
            {'title': 'Trade License', 'icon': Icons.business_center_rounded},
          ]
        : [
            {'title': 'NABL Certification', 'icon': Icons.verified_rounded},
            {'title': 'Bio-waste Handling License', 'icon': Icons.delete_forever_rounded},
            {'title': 'Pathologist License', 'icon': Icons.biotech_rounded},
            {'title': 'Radiation Safety (if applicable)', 'icon': Icons.warning_amber_rounded},
          ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('$businessType Verification')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPharmacy ? Icons.local_pharmacy_rounded : Icons.science_rounded,
                      color: AppColors.primary,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Upload regulatory documents to enable $businessType services.',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Required Documents',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...regDocs.map((doc) => _buildUploadItem(doc['title'], doc['icon'])),
            const SizedBox(height: 48),
            FadeInUp(
              child: ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Submit Documents'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadItem(String title, IconData icon) {
    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.grey, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const Text('Not uploaded', style: TextStyle(color: AppColors.textHint, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}
