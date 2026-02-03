import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class CMEUploadScreen extends StatelessWidget {
  const CMEUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Upload CME Certificate'),
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
            const Text(
              'Certificate Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
            ),
            const SizedBox(height: 24),
            _buildTextField('Event / Course Title', 'e.g., Annual Cardiology Summit 2025'),
            const SizedBox(height: 20),
            _buildTextField('CME Credits Earned', 'e.g., 5.0'),
            const SizedBox(height: 20),
            _buildTextField('Date of Completion', 'DD/MM/YYYY'),
            const SizedBox(height: 32),
            _buildUploadSection(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: RevivalColors.navyBlue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Submit for Verification', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: RevivalColors.navyBlue)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: RevivalColors.darkGrey.withOpacity(0.5), fontSize: 14),
            filled: true,
            fillColor: RevivalColors.softGrey,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1), style: BorderStyle.solid),
      ),
      child: Column(
        children: [
          const Icon(Icons.cloud_upload_outlined, size: 48, color: RevivalColors.primaryBlue),
          const SizedBox(height: 16),
          const Text(
            'Upload Certificate Attachment',
            style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 4),
          Text(
            'PDF, JPG, or PNG (Max 5MB)',
            style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
