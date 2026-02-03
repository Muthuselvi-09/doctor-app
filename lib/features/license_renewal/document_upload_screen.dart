import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        title: const Text('Upload Documents'),
        backgroundColor: RevivalColors.white,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBox(),
            const SizedBox(height: 32),
            _buildUploadCard(
              'Existing Medical License Certificate',
              'Front & Back (if applicable)',
              status: 'Uploaded',
              isUploaded: true,
            ),
            const SizedBox(height: 16),
            _buildUploadCard(
              'Medical Council Registration Certificate',
              'Permanent registration certificate',
              status: 'Pending',
              isUploaded: false,
            ),
            const SizedBox(height: 16),
            _buildUploadCard(
              'ID Proof (Aadhaar / PAN)',
              'Government issued identity card',
              status: 'Pending',
              isUploaded: false,
            ),
            const SizedBox(height: 16),
            _buildUploadCard(
              'Passport Size Photo',
              'Recent clear formal photo',
              status: 'Pending',
              isUploaded: false,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.push('/revival-reminder-setup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: RevivalColors.navyBlue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.accent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1)),
      ),
      child: const Row(
        children: [
          Icon(Icons.cloud_upload_outlined, color: RevivalColors.navyBlue),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Documents uploaded once will be reused for all future renewals.',
              style: TextStyle(
                fontSize: 13,
                color: RevivalColors.navyBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard(String title, String subtitle, {required String status, required bool isUploaded}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUploaded ? RevivalColors.success.withOpacity(0.3) : RevivalColors.midGrey,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: RevivalColors.softGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isUploaded ? Icons.file_present_rounded : Icons.image_outlined,
              color: isUploaded ? RevivalColors.success : RevivalColors.darkGrey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.navyBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isUploaded ? RevivalColors.success : RevivalColors.warning,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isUploaded ? RevivalColors.success : RevivalColors.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: Icon(
              isUploaded ? Icons.edit_note_rounded : Icons.add_a_photo_outlined,
              color: RevivalColors.navyBlue,
            ),
          ),
        ],
      ),
    );
  }
}
