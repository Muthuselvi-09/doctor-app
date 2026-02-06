import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_app/features/hospital/license_renewal/data/hospital_license_dummy_data.dart';
import 'package:doctor_app/features/hospital/license_renewal/presentation/screens/hospital_renewal_stepper_screen.dart';
import 'package:doctor_app/features/hospital/license_renewal/domain/models/hospital_license_config.dart';

class HospitalDashboardScreen extends StatelessWidget {
  const HospitalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Ultra soft blue-grey background
      appBar: AppBar(
        title: const Text('Hospital & Clinic Portal', style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF64748B)),
            onPressed: () {}, 
          ),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF64748B)),
            onPressed: () => context.push('/document-list'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Licenses & Registration'),
            const SizedBox(height: 12),
            _buildGridSection(context, [
              {'name': 'Hospital Registration', 'icon': Icons.business_rounded, 'status': 'Active', 'expiry': 'Oct 2028', 'docs': '5'},
              {'name': 'Trade License', 'icon': Icons.store_mall_directory_rounded, 'status': 'Expiring Soon', 'expiry': 'Dec 2025', 'docs': '3'},
              {'name': 'Clinical Establishment', 'icon': Icons.local_hospital_rounded, 'status': 'Pending', 'expiry': 'Jan 2026', 'docs': '2'},
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('Safety & NOCs'),
            const SizedBox(height: 12),
             _buildGridSection(context, [
              {'name': 'Fire NOC', 'icon': Icons.fire_extinguisher_outlined, 'status': 'Active', 'expiry': 'Jun 2026', 'docs': '4'},
              {'name': 'Pollution Consent', 'icon': Icons.eco_outlined, 'status': 'Active', 'expiry': 'Mar 2026', 'docs': '6'},
              {'name': 'Bio Medical Waste', 'icon': Icons.delete_outline_rounded, 'status': 'Expiring Soon', 'expiry': 'Dec 2025', 'docs': '3'},
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('Equipment & Facility'),
            const SizedBox(height: 12),
             _buildGridSection(context, [
               {'name': 'Lift Certificate', 'icon': Icons.elevator_rounded, 'status': 'Active', 'expiry': 'Aug 2026', 'docs': '2'},
               {'name': 'Generator Certificate', 'icon': Icons.electrical_services_rounded, 'status': 'Missing', 'expiry': 'Pending', 'docs': '0'},
               {'name': 'Radiology/AERB', 'icon': Icons.radio_button_checked_rounded, 'status': 'Active', 'expiry': 'Nov 2027', 'docs': '8'},
               {'name': 'X-Ray License', 'icon': Icons.medical_services_outlined, 'status': 'Active', 'expiry': 'Dec 2026', 'docs': '4'},
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('Accreditation'),
            const SizedBox(height: 12),
             _buildGridSection(context, [
               {'name': 'NABH Accreditation', 'icon': Icons.verified_user_rounded, 'status': 'Active', 'expiry': 'Jul 2027', 'docs': '12'},
               {'name': 'NABL Accreditation', 'icon': Icons.biotech_rounded, 'status': 'Pending', 'expiry': 'Sep 2026', 'docs': '5'},
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('Insurance & Liability'),
            const SizedBox(height: 12),
             _buildGridSection(context, [
               {'name': 'Building Insurance', 'icon': Icons.home_work_outlined, 'status': 'Active', 'expiry': 'Jan 2027', 'docs': '2'},
               {'name': 'Equipment Insurance', 'icon': Icons.phonelink_setup_rounded, 'status': 'Expiring Soon', 'expiry': 'Feb 2026', 'docs': '4'},
               {'name': 'Public Liability', 'icon': Icons.gavel_rounded, 'status': 'Active', 'expiry': 'May 2026', 'docs': '3'},
            ]),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF475569), // Slate 600
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildGridSection(BuildContext context, List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3, // Compact cards
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: _buildCompactCard(context, item),
        );
      },
    );
  }

  Widget _buildCompactCard(BuildContext context, Map<String, dynamic> item) {
    String status = item['status']! as String;
    Color statusColor = const Color(0xFF10B981); // Emerald 500
    Color bgGradientStart = Colors.white;
    Color bgGradientEnd = const Color(0xFFF1F5F9); // Slate 100

    if (status == 'Expiring Soon') {
      statusColor = const Color(0xFFF59E0B); // Amber 500
      bgGradientStart = const Color(0xFFFFFBEB); // Amber 50
    } else if (status == 'Pending' || status == 'Missing') {
      statusColor = const Color(0xFFEF4444); // Red 500
      bgGradientStart = const Color(0xFFFEF2F2); // Red 50
    }

    return InkWell(
      onTap: () {
         // Find matching configuration
         HospitalLicenseConfig? config;
         try {
           // Simple fuzzy matching or ID mapping for demo
           String name = item['name'];
           if (name.contains("Hospital Registration")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'hosp_reg');
           else if (name.contains("Trade")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'trade');
           else if (name.contains("Fire")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'fire');
           else if (name.contains("Pollution")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'pollution');
           else if (name.contains("Bio Medical")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'bmw');
           else if (name.contains("Clinical")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'clinical');
           else if (name.contains("Lift")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'lift');
           else if (name.contains("Radiology") || name.contains("X-Ray")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'radiology');
           else if (name.contains("NABH") || name.contains("NABL")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'nabh');
           else if (name.contains("Insurance")) config = HospitalLicenseDummyData.allLicenses.firstWhere((e) => e.id == 'insurance');
           
           // Default fallback
           config ??= HospitalLicenseDummyData.allLicenses.first;
         } catch (e) {
           config = HospitalLicenseDummyData.allLicenses.first;
         }

         Navigator.push(
           context, 
           MaterialPageRoute(builder: (context) => HospitalRenewalStepperScreen(licenseConfig: config!))
         );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)), // Slate 200
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgGradientStart, bgGradientEnd],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF64748B).withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                       BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  ),
                  child: Icon(item['icon'] as IconData, size: 18, color: const Color(0xFF334155)),
                ),
                 Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']! as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 2),
                Text(
                   status,
                   style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  item['expiry']! as String,
                   style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                ),
                Row(
                  children: [
                     const Icon(Icons.attachment_rounded, size: 10, color: Color(0xFF94A3B8)),
                     const SizedBox(width: 2),
                     Text(
                      item['docs']! as String,
                       style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
