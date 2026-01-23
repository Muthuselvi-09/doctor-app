import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class PracticeRequirementsScreen extends StatelessWidget {
  const PracticeRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Establishment Requirements'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildRequirementsStatus(),
            const SizedBox(height: 32),
            _buildRequirementsList(context),
            const SizedBox(height: 48),
            _buildActionButtons(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clinic Establishment Renewal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please ensure all 17 documents are ready for upload. Documents marked with (*) are mandatory.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsStatus() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.info_outline_rounded, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Application Readiness', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Verify all establishment certifications before proceeding.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: const Text('Pending', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementsList(BuildContext context) {
    final List<Map<String, dynamic>> requirements = [
      {'name': 'Medical License Certificate *', 'desc': 'Original registration of the lead practitioner', 'category': 'Legal'},
      {'name': 'Establishment / Trade License *', 'desc': 'Valid trade license from local municipality', 'category': 'Legal'},
      {'name': 'Shop & Establishment Registration *', 'desc': 'Valid registration under the Shops Act', 'category': 'Legal'},
      {'name': 'Clinic Address Proof *', 'desc': 'Utility bill / Telephone bill (last 3 months)', 'category': 'Address'},
      {'name': 'Rental Agreement / Ownership *', 'desc': 'Lease deed or Property Tax receipt', 'category': 'Address'},
      {'name': 'PAN / Aadhaar (Owner) *', 'desc': 'ID proof of the clinic owner', 'category': 'Identity'},
      {'name': 'Biomedical Waste Agreement *', 'desc': 'Current agreement with authorized vendor', 'category': 'Compliance'},
      {'name': 'Fire Safety Certificate *', 'desc': 'NOC from Fire Department (if applicable)', 'category': 'Compliance'},
      {'name': 'Health Dept Registration *', 'desc': 'Valid CMO / Health Dept registration', 'category': 'Legal'},
      {'name': 'List of Doctors & Qualifications *', 'desc': 'Consolidated sheet of all staff medical IDs', 'category': 'Staff'},
      {'name': 'Passport Photo (Owner) *', 'desc': 'Recent professional headshot', 'category': 'Identity'},
      {'name': 'GST Certificate', 'desc': 'GST registration if turnover > threshold', 'category': 'Tax', 'optional': true},
      {'name': 'Pollution NOC', 'desc': 'Required for diagnostics or lab facilities', 'category': 'Compliance', 'optional': true},
      {'name': 'Tax Receipt / Property Tax', 'desc': 'Recent paid receipt for clinic premises', 'category': 'Tax', 'optional': true},
      {'name': 'Equipment List', 'desc': 'Certified list of biomedical equipment', 'category': 'Inventory', 'optional': true},
      {'name': 'Digital Signature', 'desc': 'Valid DSC for online authentication', 'category': 'Identity', 'optional': true},
      {'name': 'Additional Supporting Docs', 'desc': 'Any other relevant certifications', 'category': 'Misc', 'optional': true},
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: requirements.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final req = requirements[index];
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: (req['optional'] ?? false) ? Colors.grey[100] : AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(
                    (req['optional'] ?? false) ? Icons.add_circle_outline_rounded : Icons.lock_outline_rounded,
                    color: (req['optional'] ?? false) ? Colors.grey : AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(req['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 4),
                      Text(req['desc'] as String, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert_rounded, size: 20, color: Colors.grey),
                  itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('View Details')),
                    const PopupMenuItem(child: Text('Upload Now')),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.push('/practice-upload'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            shadowColor: AppColors.primary.withOpacity(0.4),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Start Uploading', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(width: 12),
              Icon(Icons.arrow_forward_rounded),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Guideline documentation downloaded.')),
            );
          },
          child: const Text('Download Renewal Guidelines (PDF)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
        ),
      ],
    );
  }
}
