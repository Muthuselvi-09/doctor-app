import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class HospitalPortalTab extends StatelessWidget {
  const HospitalPortalTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> licenses = [
      {'title': 'Registration License', 'status': 'Approved', 'color': Colors.green},
      {'title': 'Trade License', 'status': 'Pending', 'color': Colors.orange},
      {'title': 'Fire & Safety', 'status': 'Expired', 'color': Colors.red},
      {'title': 'Pollution Control', 'status': 'Approved', 'color': Colors.green},
      {'title': 'Bio-Medical Waste', 'status': 'Under Review', 'color': Colors.blue},
      {'title': 'Clinical Establishment', 'status': 'Draft', 'color': Colors.grey},
      {'title': 'Lift License', 'status': 'Approved', 'color': Colors.green},
      {'title': 'Radiology / X-Ray', 'status': 'Approved', 'color': Colors.green},
      {'title': 'NABH / NABL', 'status': 'Pending', 'color': Colors.orange},
      {'title': 'Building Insurance', 'status': 'Approved', 'color': Colors.green},
    ];

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: FadeInDown(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hospital Portal',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: RevivalColors.deepNavy,
                        ),
                      ),
                      Text(
                        'Compliance & Certifications',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: RevivalColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list_rounded, color: RevivalColors.navyBlue),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              itemCount: licenses.length,
              itemBuilder: (context, index) {
                final license = licenses[index];
                return FadeInUp(
                  delay: Duration(milliseconds: 100 * (index % 5)),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                license['title'],
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: RevivalColors.deepNavy,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (license['color'] as Color).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  license['status'],
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: license['color'],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: RevivalColors.midGrey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
