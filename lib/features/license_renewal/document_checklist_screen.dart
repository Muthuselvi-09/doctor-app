import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';
import 'presentation/providers/compliance_providers.dart';
import 'data/license_repository.dart';
import 'presentation/providers/upload_state_provider.dart';

class DocumentChecklistScreen extends ConsumerWidget {
  final String licenseId;

  const DocumentChecklistScreen({super.key, required this.licenseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch requirement directly from LicenseRepository instead of provider
    final requirement = LicenseRepository.getRequirements(licenseId);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Required Documents'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: _buildChecklist(context, ref, requirement),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildChecklist(BuildContext context, WidgetRef ref, LicenseRequirement requirement) {
    // Note: We are now using the Repository's full document objects to render the list
    // The requirement is passed directly from the build method.
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVaultSyncIndicator(),
          const SizedBox(height: 32),
          Text(
            requirement.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 8),
          Text(
            requirement.introduction,
            style: const TextStyle(fontSize: 14, color: RevivalColors.darkGrey),
          ),
          const SizedBox(height: 24),
          ...requirement.documents.map((doc) {
            return _buildDocumentCheckItem(context, ref, doc);
          }),
        ],
      ),
    );
  }

  Widget _buildVaultSyncIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: RevivalColors.activeGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.activeGreen.withOpacity(0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.sync_rounded, color: RevivalColors.activeGreen, size: 20),
          SizedBox(width: 12),
          Text(
            'Synced with Master Vault',
            style: TextStyle(color: RevivalColors.activeGreen, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCheckItem(BuildContext context, WidgetRef ref, LicenseDocument doc) {
    final uploadedDocs = ref.watch(uploadedDocumentsProvider);
    
    bool isAvailable = false;
    bool isExpired = false;

    // Check local state first, then fallback to mock or repository logic if needed
    if (uploadedDocs.contains(doc.id)) {
      isAvailable = true;
    } else if (doc.id.contains('photo') || doc.id.contains('aadhaar') || doc.id.contains('mbbs')) {
       // Keep existing mocks for other docs if they aren't "uploaded" yet in this session
       // Or we can treat them as pre-existing
      isAvailable = true;
    }

    Color statusColor;
    String statusLabel;
    IconData statusIcon;

    if (isAvailable) {
      statusColor = RevivalColors.activeGreen;
      statusLabel = 'Available in Vault';
      statusIcon = Icons.check_circle_rounded;
    } else if (isExpired) {
      statusColor = RevivalColors.expiredRed;
      statusLabel = 'Expired - Update Required';
      statusIcon = Icons.error_rounded;
    } else {
      statusColor = RevivalColors.darkGrey;
      statusLabel = 'Missing from Vault';
      statusIcon = Icons.radio_button_unchecked_rounded;
    }


    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: RevivalColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: (isAvailable || isExpired) ? statusColor.withOpacity(0.2) : RevivalColors.darkGrey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigate to upload screen for this document
            // Passing a Map as extra to carry both ID and Title
            context.push('/revival-upload-update', extra: {
              'id': doc.id,
              'title': doc.title,
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doc.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doc.description,
                        style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                      ),
                      if (!doc.isMandatory)
                         Padding(
                           padding: const EdgeInsets.only(top: 4.0),
                           child: Text('(Optional)', style: TextStyle(fontSize: 10, color: RevivalColors.primaryBlue, fontStyle: FontStyle.italic)),
                         ),
                      const SizedBox(height: 8),
                      Text(
                        statusLabel,
                        style: TextStyle(fontSize: 11, color: statusColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                if (isAvailable)
                  const Icon(Icons.visibility_outlined, color: RevivalColors.primaryBlue, size: 20)
                else
                  const Icon(Icons.upload_file_outlined, color: RevivalColors.darkGrey, size: 20),
              ],
            ),
          ),
        ),
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
        onPressed: () => context.push('/revival-advance-reminder'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Next: Reminder Setup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
