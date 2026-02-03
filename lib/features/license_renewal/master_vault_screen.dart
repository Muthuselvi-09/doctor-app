import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';
import 'domain/models/compliance_models.dart';
import 'presentation/providers/compliance_providers.dart';

class MasterVaultScreen extends ConsumerWidget {
  const MasterVaultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(complianceDocumentsProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: const Text('Master Document Vault'),
        backgroundColor: RevivalColors.white,
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
        ),
        titleTextStyle: const TextStyle(
          color: RevivalColors.navyBlue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: documentsAsync.when(
        data: (docs) => _buildVaultContent(context, docs),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: RevivalColors.navyBlue,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Add Document', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildVaultContent(BuildContext context, List<LicenseDocument> docs) {
    final categories = ['Identity', 'Qualification', 'Address', 'Experience', 'Council Registration', 'Others'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVaultHeader(),
          const SizedBox(height: 32),
          ...categories.map((cat) {
            final catDocs = docs.where((d) => d.category == cat).toList();
            return _buildCategorySection(context, cat, catDocs);
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildVaultHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RevivalColors.primaryBlue.withOpacity(0.1)),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: RevivalColors.primaryBlue),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Documents in this vault are reused for all your license renewals and compliance needs.',
              style: TextStyle(fontSize: 14, color: RevivalColors.navyBlue, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String title, List<LicenseDocument> docs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: RevivalColors.navyBlue,
            ),
          ),
        ),
        if (docs.isEmpty)
          _buildEmptyPlaceholder(title)
        else
          ...docs.map((doc) => _buildDocumentTile(context, doc)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEmptyPlaceholder(String category) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(Icons.add_circle_outline_rounded, color: RevivalColors.darkGrey.withOpacity(0.5)),
          const SizedBox(width: 16),
          Text(
            'No $category documents uploaded',
            style: TextStyle(color: RevivalColors.darkGrey.withOpacity(0.6), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTile(BuildContext context, LicenseDocument doc) {
    Color statusColor;
    IconData statusIcon;

    switch (doc.status) {
      case DocumentStatus.verified:
        statusColor = RevivalColors.activeGreen;
        statusIcon = Icons.check_circle_rounded;
        break;
      case DocumentStatus.expired:
        statusColor = RevivalColors.expiredRed;
        statusIcon = Icons.error_rounded;
        break;
      case DocumentStatus.rejected:
        statusColor = RevivalColors.warning;
        statusIcon = Icons.cancel_rounded;
        break;
      case DocumentStatus.pending:
        statusColor = RevivalColors.expiringOrange;
        statusIcon = Icons.hourglass_empty_rounded;
        break;
      default:
        statusColor = RevivalColors.darkGrey;
        statusIcon = Icons.help_outline_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: RevivalColors.softGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.description_outlined, color: RevivalColors.navyBlue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(statusIcon, size: 12, color: statusColor),
                        const SizedBox(width: 4),
                        Text(
                          doc.status.name.toUpperCase(),
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                        ),
                        if (doc.uploadDate != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '•  ${doc.uploadDate!.day}/${doc.uploadDate!.month}/${doc.uploadDate!.year}',
                            style: const TextStyle(fontSize: 10, color: RevivalColors.darkGrey),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_outlined, color: RevivalColors.navyBlue, size: 20),
              ),
            ],
          ),
          if (doc.linkedLicenseTypes.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(height: 1),
            ),
            Row(
              children: [
                const Text(
                  'Used for: ',
                  style: TextStyle(fontSize: 10, color: RevivalColors.darkGrey, fontWeight: FontWeight.w500),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    children: doc.linkedLicenseTypes.map((type) => Text(
                      type.replaceAll('_', ' ').toUpperCase(),
                      style: const TextStyle(fontSize: 9, color: RevivalColors.primaryBlue, fontWeight: FontWeight.bold),
                    )).toList(),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
