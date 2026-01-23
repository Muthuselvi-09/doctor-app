import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class PracticeUploadScreen extends StatefulWidget {
  const PracticeUploadScreen({super.key});

  @override
  State<PracticeUploadScreen> createState() => _PracticeUploadScreenState();
}

class _PracticeUploadScreenState extends State<PracticeUploadScreen> {
  final List<Map<String, dynamic>> _documents = [
    {'name': 'Medical License Certificate', 'status': 'uploaded', 'progress': 1.0, 'mandatory': true},
    {'name': 'Establishment License', 'status': 'uploading', 'progress': 0.65, 'mandatory': true},
    {'name': 'Trade License', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Clinic Address Proof', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Rental Agreement', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Ownership Documents', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'PAN / Aadhaar (Owner)', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Biomedical Waste Agreement', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Fire Safety Certificate', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Health Dept Registration', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Staff Qualifications List', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'Passport Photo (Owner)', 'status': 'pending', 'progress': 0.0, 'mandatory': true},
    {'name': 'GST Certificate', 'status': 'pending', 'progress': 0.0, 'mandatory': false},
    {'name': 'Pollution NOC', 'status': 'pending', 'progress': 0.0, 'mandatory': false},
    {'name': 'Tax Receipt', 'status': 'pending', 'progress': 0.0, 'mandatory': false},
    {'name': 'Equipment List', 'status': 'pending', 'progress': 0.0, 'mandatory': false},
    {'name': 'Digital Signature', 'status': 'pending', 'progress': 0.0, 'mandatory': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Upload Documents'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildProgressHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Establishment Vault'),
                  const SizedBox(height: 16),
                  _buildDocumentGrid(),
                  const SizedBox(height: 32),
                  _buildSupportingBox(),
                  const SizedBox(height: 48),
                  _buildNextButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    int uploadedCount = _documents.where((doc) => doc['status'] == 'uploaded').length;
    double totalProgress = uploadedCount / _documents.length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      color: Colors.white.withOpacity(0.5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Upload Progress',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              ),
              Text(
                '$uploadedCount / ${_documents.length} Files',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: totalProgress,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 8,
            ),
          ),
        ],
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

  Widget _buildDocumentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemCount: _documents.length,
      itemBuilder: (context, index) {
        final doc = _documents[index];
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: _buildDocCard(doc),
        );
      },
    );
  }

  Widget _buildDocCard(Map<String, dynamic> doc) {
    Color statusColor;
    IconData statusIcon;
    bool isPending = doc['status'] == 'pending';
    bool isUploading = doc['status'] == 'uploading';

    if (doc['status'] == 'uploaded') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_rounded;
    } else if (isUploading) {
      statusColor = AppColors.primary;
      statusIcon = Icons.sync_rounded;
    } else {
      statusColor = Colors.grey;
      statusIcon = Icons.cloud_upload_outlined;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: statusColor.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(statusIcon, color: statusColor, size: 18),
              ),
              if (doc['mandatory'] == true)
                const Text('*', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            doc['name'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          if (isUploading)
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: doc['progress'] as double,
                    minHeight: 4,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Uploading...', style: TextStyle(fontSize: 10, color: AppColors.primary)),
              ],
            )
          else
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPending ? AppColors.primary.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                foregroundColor: isPending ? AppColors.primary : Colors.green,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isPending ? 'Upload' : 'Replace', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }

  Widget _buildSupportingBox() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.blue.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            const Icon(Icons.attachment_rounded, color: AppColors.primary, size: 32),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Additional Documents', style: TextStyle(fontWeight: FontWeight.bold)),
                   Text('Upload any other relevant certifications', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_rounded, color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () => context.push('/practice-details'),
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
          Text('Establishment Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}
