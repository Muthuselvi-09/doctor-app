import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/theme/revival_colors.dart';
import 'package:doctor_app/features/license_renewal/domain/models/compliance_models.dart';
import 'package:doctor_app/features/license_renewal/presentation/providers/compliance_providers.dart';

class DocumentListScreen extends ConsumerWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(complianceDocumentsProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: const Text(
          'Document Vault',
          style: TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
        backgroundColor: RevivalColors.white,
        elevation: 0,
        leading: const BackButton(color: RevivalColors.navyBlue),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: RevivalColors.navyBlue),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: RevivalColors.navyBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: documentsAsync.when(
        data: (documents) => ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: documents.length,
          separatorBuilder: (c, i) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final doc = documents[index];
            return FadeInUp(
              delay: Duration(milliseconds: 50 * index),
              child: _buildDocumentCard(doc),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: RevivalColors.navyBlue,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildDocumentCard(LicenseDocument doc) {
    Color statusColor;
    String statusLabel;

    switch (doc.status) {
      case DocumentStatus.verified:
        statusColor = RevivalColors.activeGreen;
        statusLabel = 'VERIFIED';
        break;
      case DocumentStatus.pending:
        statusColor = RevivalColors.pendingBlue;
        statusLabel = 'PENDING';
        break;
      case DocumentStatus.rejected:
        statusColor = RevivalColors.expiredRed;
        statusLabel = 'REJECTED';
        break;
      case DocumentStatus.expired:
        statusColor = RevivalColors.expiringOrange;
        statusLabel = 'EXPIRED';
        break;
      default:
        statusColor = RevivalColors.darkGrey;
        statusLabel = 'UNKNOWN';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: RevivalColors.accent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.description_outlined,
              color: RevivalColors.primaryBlue,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: RevivalColors.navyBlue),
                ),
                const SizedBox(height: 4),
                Text(
                  '${doc.category} • ${doc.expiryDate != null ? "Expires: ${doc.expiryDate!.day}/${doc.expiryDate!.month}/${doc.expiryDate!.year}" : "Permanent"}',
                  style: const TextStyle(color: RevivalColors.darkGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              statusLabel,
              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
