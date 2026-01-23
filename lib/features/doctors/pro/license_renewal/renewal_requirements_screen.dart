import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class RenewalRequirementsScreen extends StatelessWidget {
  const RenewalRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Renewal Requirements'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(),
            const SizedBox(height: 32),
            _buildSectionTitle('Required Documents'),
            const SizedBox(height: 16),
            _buildDocumentList(),
            const SizedBox(height: 32),
            _buildSectionTitle('Financials & Guidelines'),
            const SizedBox(height: 16),
            _buildPlaceholderSection('Renewal Fees', 'Est. ₹5,000 - ₹15,000 depending on state council.', Icons.payments_outlined),
            const SizedBox(height: 16),
            _buildPlaceholderSection('Govt. Guidelines', 'Last updated: Jan 10, 2026. View official notification.', Icons.menu_book_rounded),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Please ensure all documents are scanned in high resolution. Supported: PDF, JPG, PNG.',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return FadeInLeft(
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildDocumentList() {
    final docs = [
      {'title': 'Identity Proof', 'optional': false},
      {'title': 'Address Proof', 'optional': false},
      {'title': 'MBBS Degree', 'optional': false},
      {'title': 'Post Graduate Certificate', 'optional': true},
      {'title': 'Diploma Certificate', 'optional': true},
      {'title': 'Internship Completion Certificate', 'optional': false},
      {'title': 'Medical Council Registration Certificate', 'optional': false},
      {'title': 'Previous Renewal Certificate', 'optional': true},
      {'title': 'CME Certificates (Multi-upload)', 'optional': false},
      {'title': 'CME Hours Summary', 'optional': false},
      {'title': 'Clinic/Practice License', 'optional': false},
      {'title': 'Specialty License', 'optional': true},
      {'title': 'Passport Photo', 'optional': false},
      {'title': 'Digital Signature', 'optional': true},
      {'title': 'Additional Supporting Documents', 'optional': true},
    ];

    return Column(
      children: List.generate(docs.length, (index) {
        final doc = docs[index];
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: _DocumentRequirementCard(
            title: doc['title'] as String,
            isOptional: doc['optional'] as bool,
            status: index == 0 ? 'Verified' : (index < 3 ? 'Pending' : 'Not Uploaded'),
          ),
        );
      }),
    );
  }

  Widget _buildPlaceholderSection(String title, String subtitle, IconData icon) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}

class _DocumentRequirementCard extends StatelessWidget {
  final String title;
  final bool isOptional;
  final String status;

  const _DocumentRequirementCard({
    required this.title,
    required this.isOptional,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Verified':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'Rejected':
        statusColor = Colors.red;
        statusIcon = Icons.cancel_rounded;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_empty_rounded;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.cloud_upload_outlined;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isOptional) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.textHint.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'OPTIONAL',
                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_rounded, color: AppColors.textHint),
            onSelected: (value) {
              if (value == 'upload') {
                context.push('/upload-preview', extra: title);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'view', child: Text('View Details')),
              PopupMenuItem(value: 'upload', child: Text(status == 'Verified' ? 'Update' : 'Upload')),
            ],
          ),
        ],
      ),
    );
  }
}
