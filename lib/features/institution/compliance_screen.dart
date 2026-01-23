import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class InstitutionComplianceScreen extends StatefulWidget {
  const InstitutionComplianceScreen({super.key});

  @override
  State<InstitutionComplianceScreen> createState() => _InstitutionComplianceScreenState();
}

class _InstitutionComplianceScreenState extends State<InstitutionComplianceScreen> {
  final Map<String, bool> _complianceDocs = {
    'Clinic/Hospital Registration': true,
    'Trade License': true,
    'Fire Safety Compliance': false,
    'Pollution Control Certificate': false,
    'Biomedical Waste License': false,
    'GST + Tax Registration': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Institutional Compliance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComplianceHeader(),
            const SizedBox(height: 32),
            _buildSectionTitle('Regulatory Documents'),
            const SizedBox(height: 16),
            ..._complianceDocs.keys.map((title) => _buildDocItem(title, _complianceDocs[title]!)),
            const SizedBox(height: 32),
            _buildFacilitySection(),
            const SizedBox(height: 40),
            FadeInUp(
              child: ElevatedButton(
                onPressed: () => context.go('/hospital-dashboard'),
                child: const Text('Complete Registration'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.purple.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.gavel_rounded, color: Colors.purple, size: 40),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Legally practice & operate your medical establishment.',
                    style: TextStyle(height: 1.4, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.purple.withOpacity(0.1),
              color: Colors.purple,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 8),
            const Text(
              '50% Verification completed',
              style: TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildDocItem(String title, bool isUploaded) {
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
            Icon(
              isUploaded ? Icons.verified_rounded : Icons.error_outline_rounded,
              color: isUploaded ? Colors.green : Colors.redAccent,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ),
            Text(
              isUploaded ? 'View' : 'Upload',
              style: TextStyle(
                color: isUploaded ? AppColors.primary : Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacilitySection() {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Facilities (Optional)'),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFacilityChip('24/7 Pharmacy', true),
              const SizedBox(width: 8),
              _buildFacilityChip('MRI/CT Lab', false),
              const SizedBox(width: 8),
              _buildFacilityChip('OT Suite', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? Colors.purple : Colors.black.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
