import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';
import '../providers/admin_providers.dart';
import '../../domain/models/admin_models.dart';

class ApplicationReviewScreen extends ConsumerWidget {
  final String? applicationId;

  const ApplicationReviewScreen({super.key, this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If no ID is passed (e.g. direct route), fallback or error.
    // In a real app we'd handle route params better.
    // For now assuming ID is passed via extra or state.
    final id = applicationId ??
        GoRouterState.of(context).extra as String?;

    if (id == null) {
      return const Scaffold(body: Center(child: Text('No application ID found')));
    }

    final appAsync = ref.watch(applicationReviewProvider(id));

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: RevivalColors.deepNavy),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Application Review',
          style: GoogleFonts.outfit(
            color: RevivalColors.deepNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: appAsync.when(
        data: (app) {
          if (app == null) return const Center(child: Text('Application not found'));
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(app),
                const SizedBox(height: 24),
                _buildDetails(app),
                const SizedBox(height: 24),
                _buildDocumentsSection(context, ref, app),
                const SizedBox(height: 24),
                 if (app.status == ApplicationStatus.approved && app.certificateUrl != null)
                  _buildCertificateSection(app),

                const SizedBox(height: 32),
                _buildActionButtons(context, ref, app),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildHeader(LicenseApplication app) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: RevivalColors.accent,
            child: Text(
                app.userName.substring(0, 1).toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.userName,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.deepNavy,
                  ),
                ),
                Text(
                  '${app.type.name} - ${app.id}',
                  style: GoogleFonts.outfit(
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: app.statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                app.statusLabel,
                style: GoogleFonts.outfit(
                  color: app.statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(LicenseApplication app) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          _DetailRow(label: 'Date Submitted', value: '${app.submissionDate.day}/${app.submissionDate.month}/${app.submissionDate.year}'),
          _DetailRow(label: 'License Number', value: app.licenseNumber),
          _DetailRow(label: 'User Type', value: app.userType),
          if (app.externalApplicationNumber != null)
             _DetailRow(label: 'Ext. App Number', value: app.externalApplicationNumber!),
          if (app.expectedApprovalDate != null)
             _DetailRow(label: 'Expected Approval', value: '${app.expectedApprovalDate!.day}/${app.expectedApprovalDate!.month}/${app.expectedApprovalDate!.year}'),
        ],
      ),
    );
  }
  
  Widget _buildDocumentsSection(BuildContext context, WidgetRef ref, LicenseApplication app) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
            'Uploaded Documents',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: RevivalColors.deepNavy,
            ),
          ),
          const SizedBox(height: 12),
          if (app.documents.isEmpty)
             const Text('No documents uploaded yet.'),
          
          ...app.documents.map((doc) => _DocumentCard(app: app, doc: doc, ref: ref)),
       ],
     );
  }
  
   Widget _buildCertificateSection(LicenseApplication app) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('License Certificate Generated', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.green[800])),
                Text('Ready for download by user', style: GoogleFonts.outfit(fontSize: 12)),
              ],
            ),
          ),
          TextButton(onPressed: (){}, child: const Text('View'))
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, LicenseApplication app) {
    final controller = ref.read(adminControllerProvider.notifier);
    
    // Logic for available actions based on status
    if (app.status == ApplicationStatus.approved || app.status == ApplicationStatus.rejected) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {}, 
          child: const Text('Re-open Application')
        ),
      ); 
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _showRejectDialog(context, ref, app),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Reject'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showApproveDialog(context, ref, app),
                style: ElevatedButton.styleFrom(
                  backgroundColor: RevivalColors.navyBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Next Status'),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  void _showRejectDialog(BuildContext context, WidgetRef ref, LicenseApplication app) {
     final reasonController = TextEditingController();
     showDialog(
       context: context, 
       builder: (context) => AlertDialog(
         title: const Text('Reject Application'),
         content: TextField(
           controller: reasonController,
           decoration: const InputDecoration(hintText: 'Reason for rejection...'),
           maxLines: 3,
         ),
         actions: [
           TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
           ElevatedButton(
             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
             onPressed: () {
               ref.read(adminControllerProvider.notifier)
                .updateApplicationStatus(app.id, ApplicationStatus.rejected, rejectionReason: reasonController.text);
               context.pop();
             }, 
             child: const Text('Confirm Reject')
            ),
         ],
       )
     );
  }
  
    void _showApproveDialog(BuildContext context, WidgetRef ref, LicenseApplication app) {
     // Determine next logical status
     ApplicationStatus nextStatus = ApplicationStatus.underVerification;
     if (app.status == ApplicationStatus.received) {
       nextStatus = ApplicationStatus.underVerification;
     } else if (app.status == ApplicationStatus.underVerification) nextStatus = ApplicationStatus.appliedExternally;
     else if (app.status == ApplicationStatus.appliedExternally) nextStatus = ApplicationStatus.underAuthorityReview;
     else if (app.status == ApplicationStatus.underAuthorityReview) nextStatus = ApplicationStatus.approved;
     
     final extNumController = TextEditingController(text: app.externalApplicationNumber);
     
     showDialog(
       context: context, 
       builder: (context) => AlertDialog(
         title: Text('Update Status to ${_formatStatus(nextStatus)}'),
         content: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             if (nextStatus == ApplicationStatus.appliedExternally)
                TextField(
                  controller: extNumController,
                  decoration: const InputDecoration(labelText: 'External Application Number (from Govt Portal)'),
                ),
             if (nextStatus == ApplicationStatus.approved)
                 const Text('This will mark the license as completely approved. You can upload the certificate later.'),
             const SizedBox(height: 10),
             const Text('Are you sure you want to proceed?'),
           ],
         ),
         actions: [
           TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
           ElevatedButton(
             onPressed: () {
               ref.read(adminControllerProvider.notifier)
                .updateApplicationStatus(app.id, nextStatus, externalAppNum: extNumController.text.isNotEmpty ? extNumController.text : null);
               context.pop();
             }, 
             child: const Text('Update')
            ),
         ],
       )
     );
  }
  
  String _formatStatus(ApplicationStatus status) {
    return status.toString().split('.').last.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}').trim();
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(color: RevivalColors.darkGrey),
          ),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600,
              color: RevivalColors.deepNavy,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final LicenseApplication app;
  final LicenseDocument doc;
  final WidgetRef ref;

  const _DocumentCard({required this.app, required this.doc, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RevivalColors.midGrey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.picture_as_pdf, color: RevivalColors.navyBlue, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  doc.name,
                  style: GoogleFonts.outfit(
                    color: RevivalColors.deepNavy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              _buildStatusChip(doc.status),
            ],
          ),
           if (doc.adminRemark != null)
             Padding(
               padding: const EdgeInsets.only(top: 8, left: 36),
               child: Text(
                 'Note: ${doc.adminRemark}',
                 style: const TextStyle(color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic),
               ),
             ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  // Mock viewing
                },
                icon: const Icon(Icons.visibility_outlined, size: 16),
                label: const Text('View'),
              ),
              if (doc.status == DocumentStatus.pending) ...[
                 TextButton.icon(
                  onPressed: () => _rejectDoc(context),
                  icon: const Icon(Icons.close, size: 16, color: Colors.red),
                  label: const Text('Reject', style: TextStyle(color: Colors.red)),
                ),
                TextButton.icon(
                  onPressed: () {
                     ref.read(adminControllerProvider.notifier)
                        .updateDocumentStatus(app.id, doc.id, DocumentStatus.verified);
                  },
                  icon: const Icon(Icons.check, size: 16, color: Colors.green),
                  label: const Text('Verify', style: TextStyle(color: Colors.green)),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }
  
  void _rejectDoc(BuildContext context) {
     final remarkController = TextEditingController();
      showDialog(
       context: context, 
       builder: (context) => AlertDialog(
         title: const Text('Reject Document'),
         content: TextField(
           controller: remarkController,
           decoration: const InputDecoration(hintText: 'Reason (e.g. Blurry, Wrong Year)'),
         ),
         actions: [
            TextButton(onPressed: () => context.pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                ref.read(adminControllerProvider.notifier)
                  .updateDocumentStatus(app.id, doc.id, DocumentStatus.rejected, remark: remarkController.text);
                context.pop();
              }, 
              child: const Text('Reject')
            )
         ],
       )
      );
  }

  Widget _buildStatusChip(DocumentStatus status) {
    Color color;
    IconData icon;
    
    switch (status) {
      case DocumentStatus.verified:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case DocumentStatus.rejected:
      case DocumentStatus.reuploadRequired:
        color = Colors.red;
        icon = Icons.error;
        break;
      case DocumentStatus.missing:
        color = Colors.orange;
        icon = Icons.warning;
        break;
      case DocumentStatus.pending:
      default:
        color = Colors.grey;
        icon = Icons.hourglass_empty;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            status.name, 
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  }
}

