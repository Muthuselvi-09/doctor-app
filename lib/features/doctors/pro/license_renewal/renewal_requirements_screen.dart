import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/theme/revival_colors.dart';
import 'package:doctor_app/features/license_renewal/domain/models/compliance_models.dart';
import 'package:doctor_app/features/license_renewal/presentation/providers/compliance_providers.dart';

class RenewalRequirementsScreen extends ConsumerWidget {
  const RenewalRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(licenseServicesProvider);
    final documentsAsync = ref.watch(complianceDocumentsProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Requirements Checklist',
          style: TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: servicesAsync.when(
        data: (services) {
          // Mock: current service is 'med_renewal'
          final service = services.firstWhere((s) => s.id == 'med_renewal');
          
          return documentsAsync.when(
            data: (vaultDocs) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Required Documents'),
                    const SizedBox(height: 16),
                    ...service.requiredDocumentIds.map((docId) {
                      final vaultDoc = vaultDocs.firstWhere(
                        (d) => d.id == docId,
                        orElse: () => LicenseDocument(id: docId, name: _getFallbackDocName(docId), category: 'General'),
                      );
                      return _buildDocumentRequirementCard(context, vaultDoc);
                    }),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Financials & Guidelines'),
                    const SizedBox(height: 16),
                    _buildPlaceholderSection('Renewal Fees', 'Est. ₹5,000 - ₹15,000', Icons.payments_outlined),
                    const SizedBox(height: 16),
                    _buildPlaceholderSection('Govt. Guidelines', 'Last updated: Jan 10, 2026', Icons.menu_book_rounded),
                    const SizedBox(height: 80),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Center(child: Text('Error: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: RevivalColors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => context.push('/revival-document-upload'),
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Proceed to Upload', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  String _getFallbackDocName(String id) {
    if (id == 'doc_reg_cert') return 'Medical Council Registration';
    if (id == 'doc_passport_photo') return 'Passport Size Photo';
    return 'Supporting Document';
  }

  Widget _buildInfoCard() {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: RevivalColors.accent.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: RevivalColors.primaryBlue, size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Documents already in your vault will be reused automatically. Please upload missing ones.',
                style: TextStyle(color: RevivalColors.navyBlue, fontSize: 13, height: 1.4),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
      );
  }

  Widget _buildDocumentRequirementCard(BuildContext context, LicenseDocument doc) {
    Color statusColor;
    IconData statusIcon;
    String statusLabel;

    switch (doc.status) {
      case DocumentStatus.verified:
        statusColor = RevivalColors.activeGreen;
        statusIcon = Icons.check_circle_rounded;
        statusLabel = 'VERIFIED';
        break;
      case DocumentStatus.pending:
        statusColor = RevivalColors.pendingBlue;
        statusIcon = Icons.hourglass_empty_rounded;
        statusLabel = 'IN VAULT';
        break;
      case DocumentStatus.rejected:
        statusColor = RevivalColors.expiredRed;
        statusIcon = Icons.cancel_rounded;
        statusLabel = 'REJECTED';
        break;
      default:
        statusColor = RevivalColors.darkGrey;
        statusIcon = Icons.cloud_upload_outlined;
        statusLabel = 'MISSING';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: RevivalColors.navyBlue),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 6),
                    Text(
                      statusLabel,
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (doc.status != DocumentStatus.verified)
            IconButton(
              icon: const Icon(Icons.add_a_photo_outlined, color: RevivalColors.primaryBlue, size: 20),
              onPressed: () => context.push('/revival-document-upload'),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderSection(String title, String subtitle, IconData icon) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: RevivalColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: RevivalColors.accent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: RevivalColors.primaryBlue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: RevivalColors.navyBlue)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: RevivalColors.darkGrey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: RevivalColors.darkGrey),
          ],
        ),
      );
  }
}
