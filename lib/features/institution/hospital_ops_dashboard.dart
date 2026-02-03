import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/revival_colors.dart';
import '../../features/license_renewal/logic/renewal_flow_coordinator.dart';

class HospitalOpsDashboard extends StatelessWidget {
  const HospitalOpsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text('Hospital License Portal', 
          style: GoogleFonts.outfit(
            color: RevivalColors.deepNavy, 
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: RevivalColors.deepNavy),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSectionHeader('Mandatory Licenses (12)'),
            const SizedBox(height: 12),
            _buildLicenseGrid(context),
            const SizedBox(height: 32),
             _buildTrackingSection(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.navyBlue,
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [RevivalColors.navyBlue, Color(0xFF475569)]),
      ),
      child: Row(
        children: [
          const Icon(Icons.apartment, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('City Care Hospital', style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text('REG: HSP-2024-001', style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy),
    );
  }

  Widget _buildLicenseGrid(BuildContext context) {
    final licenses = [
      {'name': 'Registration License', 'icon': Icons.domain},
      {'name': 'Trade License', 'icon': Icons.store},
      {'name': 'Fire & Safety', 'icon': Icons.fire_extinguisher},
      {'name': 'Pollution Control', 'icon': Icons.air},
      {'name': 'Bio-Medical Waste', 'icon': Icons.delete_sweep},
      {'name': 'Clinical Establishment', 'icon': Icons.local_hospital},
      {'name': 'Lift License', 'icon': Icons.elevator},
      {'name': 'Generator Set', 'icon': Icons.bolt},
      {'name': 'Radiology/Ultrasonography', 'icon': Icons.wifi_tethering}, // Approximation
      {'name': 'X-Ray License', 'icon': Icons.medical_services},
      {'name': 'NABH / NABL', 'icon': Icons.verified},
      {'name': 'Building Insurance', 'icon': Icons.security},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Dense grid for 12 items
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: licenses.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: _buildLicenseCard(context, licenses[index]),
        );
      },
    );
  }
  
  Widget _buildLicenseCard(BuildContext context, Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        // Strict Flow Step 1 -> 2
        RenewalFlowCoordinator.startRenewal(context, item['name']);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: RevivalColors.softGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(item['icon'] as IconData, color: RevivalColors.navyBlue, size: 20),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                item['name'] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 11, fontWeight: FontWeight.w600, color: RevivalColors.deepNavy),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
             const SizedBox(height: 4),
             Text('Active', style: GoogleFonts.outfit(fontSize: 10, color: Colors.green)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingSection() {
     return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
           border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Renewal Tracking', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _buildTrackItem('Fire & Safety', 0.8),
            const SizedBox(height: 12),
            _buildTrackItem('Bio-Medical Waste', 0.4),
          ],
        ),
     );
  }
  
  Widget _buildTrackItem(String name, double val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(name, style: GoogleFonts.outfit(fontSize: 13)),
             Text('${(val * 100).toInt()}%', style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.primaryBlue)),
           ],
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(value: val, backgroundColor: RevivalColors.softGrey, color: RevivalColors.primaryBlue, minHeight: 6, borderRadius: BorderRadius.circular(4)),
      ],
    );
  }
}

