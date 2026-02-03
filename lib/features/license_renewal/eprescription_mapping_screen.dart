import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class EPrescriptionMappingScreen extends StatelessWidget {
  const EPrescriptionMappingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('License Mapping'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Map Licenses to E-Rx System',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select the licenses you want to authorize for generating digital prescriptions.',
              style: TextStyle(fontSize: 14, color: RevivalColors.darkGrey),
            ),
            const SizedBox(height: 32),
            _buildLicenseMappingTile('Medical License (Permanent)', 'MC-12345', true),
            _buildLicenseMappingTile('Speciality License (MD)', 'SPEC-9910', true),
            _buildLicenseMappingTile('Clinic Operating Permit', 'CL-0081', false),
            const SizedBox(height: 48),
            _buildSecurityNotice(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildLicenseMappingTile(String title, String id, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? RevivalColors.primaryBlue.withOpacity(0.05) : RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: RevivalColors.primaryBlue.withOpacity(0.2)) : null,
      ),
      child: Row(
        children: [
          Icon(isSelected ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded, color: isSelected ? RevivalColors.primaryBlue : RevivalColors.darkGrey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
                Text(id, style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.security_rounded, color: Colors.orange),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'All prescriptions generated through this system will carry a verifiable digital signature linked to these licenses.',
              style: TextStyle(fontSize: 12, color: RevivalColors.navyBlue, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: ElevatedButton(
        onPressed: () => context.push('/revival-eprescription-confirmation'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Enable E-Prescription', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
