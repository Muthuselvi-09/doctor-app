import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class EPrescriptionEligibilityScreen extends StatelessWidget {
  const EPrescriptionEligibilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('E-Prescription Enablement'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildHeroImage(),
            const SizedBox(height: 32),
            _buildBenefitSection(),
            const SizedBox(height: 32),
            _buildChecklist(),
            const SizedBox(height: 48),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Icon(Icons.electric_bolt_rounded, size: 80, color: RevivalColors.primaryBlue),
      ),
    );
  }

  Widget _buildBenefitSection() {
    return Column(
      children: [
        const Text(
          'Legally Enable Digital Prescriptions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Enable compliant e-prescribing tools for your practice by linking your verified licenses.',
          style: TextStyle(fontSize: 14, color: RevivalColors.darkGrey, height: 1.4),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildChecklist() {
    return Column(
      children: [
        _buildCheckItem('Verified Medical License', true),
        _buildCheckItem('Active Practice Permit', true),
        _buildCheckItem('Unique Doctor ID (DigiDoctor)', false),
      ],
    );
  }

  Widget _buildCheckItem(String title, bool isReady) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(isReady ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: isReady ? RevivalColors.activeGreen : RevivalColors.darkGrey, size: 24),
          const SizedBox(width: 16),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isReady ? RevivalColors.navyBlue : RevivalColors.darkGrey)),
          const Spacer(),
          if (!isReady)
            const Text('Action Required', style: TextStyle(color: RevivalColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.bold)),
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
        onPressed: () => context.push('/revival-eprescription-mapping'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Start Mapping Process', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
