import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/revival_colors.dart';
import '../../features/license_renewal/logic/renewal_flow_coordinator.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text('Pharmacy Portal', 
          style: GoogleFonts.outfit(
            color: RevivalColors.deepNavy, 
            fontWeight: FontWeight.bold
          )
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: RevivalColors.deepNavy),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: RevivalColors.navyBlue,
              child: Icon(Icons.local_pharmacy, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
             const SizedBox(height: 24),
            
            _buildSectionHeader('License Renewals'),
            const SizedBox(height: 12),
            _buildLicenseGrid(context),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Compliance & Safety'),
            const SizedBox(height: 12),
             _buildComplianceGrid(context),
             
             const SizedBox(height: 32),
             _buildTrackingSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {}, // TODO: Link to Invoice/Support
        backgroundColor: RevivalColors.navyBlue,
        icon: const Icon(Icons.support_agent),
        label: Text('Support', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: RevivalColors.navyBlue,
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [RevivalColors.navyBlue, Color(0xFF334155)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Green Cross Pharmacy',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'License ID: PHARM-1122-3344',
                    style: GoogleFonts.outfit(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '3 Renewals Due',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.storefront, color: Colors.white, size: 40),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: RevivalColors.deepNavy,
      ),
    );
  }

  Widget _buildLicenseGrid(BuildContext context) {
    final licenses = [
      {'name': 'Drug License Renewal', 'expiry': 'Expiring in 30 days', 'status': 'Urgent', 'icon': Icons.medication},
      {'name': 'Pharmacy Registration', 'expiry': 'Valid till Oct 2026', 'status': 'Active', 'icon': Icons.assignment_turned_in},
      {'name': 'Establishment License', 'expiry': 'Valid till Dec 2025', 'status': 'Active', 'icon': Icons.business},
      {'name': 'Trade License', 'expiry': 'Expiring in 2 months', 'status': 'Pending', 'icon': Icons.store},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: licenses.length,
      itemBuilder: (context, index) {
        final license = licenses[index];
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          child: _buildServiceCard(context, license),
        );
      },
    );
  }
  
  Widget _buildComplianceGrid(BuildContext context) {
    final services = [
      {'name': 'Cold Storage License', 'expiry': 'Valid', 'status': 'Active', 'icon': Icons.ac_unit},
      {'name': 'Bio-Medical Waste', 'expiry': 'Renewal Due', 'status': 'Urgent', 'icon': Icons.delete_sweep},
      {'name': 'Fire Safety', 'expiry': 'Valid', 'status': 'Active', 'icon': Icons.fire_extinguisher},
      {'name': 'Insurance Policy', 'expiry': 'Valid', 'status': 'Active', 'icon': Icons.shield},
    ];
    
     return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index + 400),
          child: _buildServiceCard(context, service),
        );
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> item) {
    Color statusColor = Colors.green;
    if (item['status'] == 'Urgent') statusColor = Colors.orange;
    if (item['status'] == 'Pending') statusColor = Colors.red;

    return GestureDetector(
      onTap: () {
         // Strict Flow using Coordinator
         // Step 1 -> 2
         RenewalFlowCoordinator.startRenewal(context, item['name']);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: RevivalColors.softGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item['icon'] as IconData, size: 24, color: RevivalColors.navyBlue),
                ),
                 Container(
                  width: 8,
                  height: 8,
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
                  item['name'] as String,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: RevivalColors.deepNavy,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item['expiry'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTrackingSection() {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Renewal Tracking',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.deepNavy,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTrackingItem('Drug License', 'Under Verification', 0.6),
            const SizedBox(height: 16),
            _buildTrackingItem('Bio-Medical Waste', 'Review Pending', 0.3),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTrackingItem(String title, String status, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w500)),
            Text(status, style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.primaryBlue)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: RevivalColors.softGrey,
          valueColor: const AlwaysStoppedAnimation<Color>(RevivalColors.primaryBlue),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}

