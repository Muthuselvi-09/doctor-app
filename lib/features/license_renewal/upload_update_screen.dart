import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';
import 'presentation/providers/compliance_providers.dart';
import 'presentation/providers/upload_state_provider.dart';

class UploadUpdateScreen extends ConsumerWidget {
  final String documentTitle;
  final String? documentId; // Optional ID to target specific upload

  const UploadUpdateScreen({super.key, required this.documentTitle, this.documentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (documentId != null) {
      return _buildDedicatedUploadView(context, ref);
    }
    
    // Legacy view for dashboard/summary (if needed)
    final missingIds = ['doc_experience'];
    final expiredIds = ['doc_license_old'];

    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: Text(documentTitle),
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
            _buildSectionHeader('Missing Documents', 'Please upload these to proceed with your renewal.'),
            ...missingIds.map((id) => _buildUploadTile(id, isMissing: true, context: context, ref: ref)),
            const SizedBox(height: 32),
            _buildSectionHeader('Expired Documents', 'These documents have expired and need an updated version.'),
            ...expiredIds.map((id) => _buildUploadTile(id, isExpired: true, context: context, ref: ref)),
            const SizedBox(height: 48),
            _buildTeamNotice(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildDedicatedUploadView(BuildContext context, WidgetRef ref) {
    final isUploaded = ref.watch(uploadedDocumentsProvider).contains(documentId);
    
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: Text(documentTitle),
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
            _buildStatusBadge(isUploaded),
            const SizedBox(height: 24),
            const Text(
              'Document Description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: RevivalColors.navyBlue),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please upload a clear copy of the document. Ensure all details are visible and the text is readable.',
              style: TextStyle(fontSize: 14, color: RevivalColors.darkGrey, height: 1.5),
            ),
             const SizedBox(height: 32),
            if (isUploaded) 
              _buildFilePreviewCard(context, ref)
            else
              _buildUploadArea(context, ref),
              
             const SizedBox(height: 40),
             _buildTeamNotice(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: RevivalColors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          onPressed: isUploaded ? () => context.pop() : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            disabledBackgroundColor: RevivalColors.softGrey,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text(
            'Save Document', 
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isUploaded ? Colors.white : RevivalColors.darkGrey)
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isUploaded) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isUploaded ? RevivalColors.activeGreen.withOpacity(0.1) : RevivalColors.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isUploaded ? RevivalColors.activeGreen.withOpacity(0.2) : RevivalColors.primaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isUploaded ? Icons.check_circle : Icons.info_outline, size: 16, color: isUploaded ? RevivalColors.activeGreen : RevivalColors.primaryBlue),
          const SizedBox(width: 8),
          Text(
            isUploaded ? 'Ready for Submission' : 'Pending Upload',
            style: TextStyle(
              color: isUploaded ? RevivalColors.activeGreen : RevivalColors.primaryBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadArea(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
         // Simulate file picking and upload
         ref.read(uploadedDocumentsProvider.notifier).uploadDocument(documentId!);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: RevivalColors.softGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: RevivalColors.darkGrey.withOpacity(0.3), width: 1, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
              child: const Icon(Icons.cloud_upload_rounded, color: RevivalColors.primaryBlue, size: 32),
            ),
            const SizedBox(height: 16),
            const Text('Tap to Upload File', style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
            const SizedBox(height: 8),
            const Text('PDF, JPG, PNG (Max 5MB)', style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilePreviewCard(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: RevivalColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: RevivalColors.darkGrey.withOpacity(0.2)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.picture_as_pdf, color: Colors.red),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$documentTitle.pdf',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text('2.4 MB • Uploaded just now', style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye_outlined, color: RevivalColors.darkGrey)),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: () {
            // Logic to re-upload (could verify with user first, but here just updating state)
             ref.read(uploadedDocumentsProvider.notifier).uploadDocument(documentId!);
          },
          icon: const Icon(Icons.refresh_rounded, size: 16),
          label: const Text('Replace File'),
          style: TextButton.styleFrom(foregroundColor: RevivalColors.primaryBlue),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 14, color: RevivalColors.darkGrey),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUploadTile(String id, {bool isMissing = false, bool isExpired = false, bool isTarget = false, required BuildContext context, required WidgetRef ref}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: RevivalColors.white, shape: BoxShape.circle),
                child: Icon(
                  isMissing ? Icons.add_a_photo_outlined : Icons.update_rounded,
                  color: RevivalColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTarget ? documentTitle : _getDocNameById(id),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isMissing ? 'Not found in Vault' : 'Expired 30 days ago',
                      style: TextStyle(fontSize: 12, color: isMissing ? RevivalColors.darkGrey : RevivalColors.expiredRed),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: RevivalColors.navyBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Upload', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          if (isExpired) ...[
            const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
            InkWell(
              onTap: () {},
              child: const Row(
                children: [
                  Icon(Icons.history_rounded, size: 14, color: RevivalColors.darkGrey),
                  SizedBox(width: 8),
                  Text('View old document for reference', style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey, decoration: TextDecoration.underline)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getDocNameById(String id) {
    switch (id) {
      case 'doc_experience': return 'Experience / Practice Proof';
      case 'doc_license_old': return 'Old Medical License';
      default: return 'Supportive Document';
    }
  }

  Widget _buildTeamNotice() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RevivalColors.primaryBlue.withOpacity(0.1)),
      ),
      child: const Column(
        children: [
          Icon(Icons.verified_user_outlined, color: RevivalColors.primaryBlue, size: 30),
          SizedBox(height: 12),
          Text(
            'Admin Team Verification',
            style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          ),
          SizedBox(height: 8),
          Text(
            'Once uploaded, our admin team will verify the documents against authority requirements before applying for renewal.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey, height: 1.4),
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
        onPressed: () => context.push('/revival-review-consent'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Review & Provide Consent', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
