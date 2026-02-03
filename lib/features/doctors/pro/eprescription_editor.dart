import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/revival_colors.dart';
import 'package:doctor_app/features/license_renewal/domain/models/compliance_models.dart';
import 'package:doctor_app/features/license_renewal/presentation/providers/compliance_providers.dart';

class EPrescriptionEditor extends ConsumerStatefulWidget {
  const EPrescriptionEditor({super.key});

  @override
  ConsumerState<EPrescriptionEditor> createState() => _EPrescriptionEditorState();
}

class _EPrescriptionEditorState extends ConsumerState<EPrescriptionEditor> {
  final List<Map<String, String>> _medicines = [
    {'name': 'Amoxicillin 500mg', 'dose': '1-0-1', 'duration': '5 Days'},
    {'name': 'Paracetamol 650mg', 'dose': '0-0-1', 'duration': '3 Days'},
  ];

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(licenseServicesProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: const Text('Digital Prescription', style: TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold)),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        leading: const BackButton(color: RevivalColors.navyBlue),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: RevivalColors.navyBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.print_outlined, color: RevivalColors.navyBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: servicesAsync.when(
        data: (services) {
          final medLicense = services.firstWhere((s) => s.id == 'med_renewal');
          final isLicenseActive = medLicense.status == LicenseStatus.active;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isLicenseActive) _buildLicenseWarning(medLicense),
                const SizedBox(height: 16),
                _buildPatientHeader(),
                const SizedBox(height: 32),
                _buildSectionTitle('Diagnosis / Findings'),
                const SizedBox(height: 12),
                _buildDiagnosisInput(),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle('Medications'),
                    TextButton.icon(
                      onPressed: isLicenseActive ? () {} : null,
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Add Medicine'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._medicines.map((med) => _buildMedicineItem(med)),
                const SizedBox(height: 32),
                _buildSectionTitle('Advice / Follow-up'),
                const SizedBox(height: 12),
                _buildDiagnosisInput(hint: 'Enter dietary advice or follow-up date'),
                const SizedBox(height: 48),
                FadeInUp(
                  child: ElevatedButton(
                    onPressed: isLicenseActive ? () => Navigator.pop(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RevivalColors.navyBlue,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      disabledBackgroundColor: RevivalColors.midGrey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.send_rounded, color: Colors.white),
                        const SizedBox(width: 12),
                        Text(
                          isLicenseActive ? 'Send to Patient' : 'Locked (License Inactive)',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildLicenseWarning(LicenseService license) {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: RevivalColors.expiredRed.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RevivalColors.expiredRed.withOpacity(0.2)),
        ),
        child: Row(
          children: [
             const Icon(Icons.gavel_rounded, color: RevivalColors.expiredRed, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'License Verification Required',
                    style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.expiredRed, fontSize: 14),
                  ),
                  Text(
                    'Your Medical License is ${license.status.name}. Please renew to enable e-prescriptions.',
                    style: const TextStyle(color: RevivalColors.expiredRed, fontSize: 12),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {}, // Navigate to renewal
              child: const Text('Renew Now', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: RevivalColors.accent,
              child: Icon(Icons.person, color: RevivalColors.primaryBlue),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jane Cooper', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: RevivalColors.navyBlue)),
                  Text('Female, 28y • ID: #P-8821', style: TextStyle(color: RevivalColors.darkGrey, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.history_rounded, color: RevivalColors.primaryBlue, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
    );
  }

  Widget _buildDiagnosisInput({String hint = 'Enter clinical diagnosis...'}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
      ),
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: RevivalColors.darkGrey, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildMedicineItem(Map<String, String> med) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          const Icon(Icons.medication_outlined, color: RevivalColors.primaryBlue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med['name']!, style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
                Text('${med['dose']} • ${med['duration']}', style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: RevivalColors.expiredRed, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
