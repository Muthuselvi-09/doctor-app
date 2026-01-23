import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class DoctorVerificationScreen extends StatefulWidget {
  const DoctorVerificationScreen({super.key});

  @override
  State<DoctorVerificationScreen> createState() => _DoctorVerificationScreenState();
}

class _DoctorVerificationScreenState extends State<DoctorVerificationScreen> {
  final Map<String, String?> _uploadStatus = {
    'Medical Degree': null,
    'Practice License': 'Verified',
    'Specialty License': 'Pending',
    'ID Proof (Aadhar/Passport)': null,
    'Pan Card': null,
    'Medical Indemnity Insurance': null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Professional Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildSectionTitle('Mandatory Documents'),
            const SizedBox(height: 16),
            ..._uploadStatus.keys.map((title) => _buildUploadItem(title, _uploadStatus[title])),
            const SizedBox(height: 32),
            _buildSectionTitle('Bank Details (Payouts)'),
            const SizedBox(height: 16),
            _buildPayoutSetupCard(),
            const SizedBox(height: 40),
            FadeInUp(
              child: ElevatedButton(
                onPressed: () => context.go('/doctor-dashboard'),
                child: const Text('Submit for Review'),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        ),
        child: const Row(
          children: [
            Icon(Icons.verified_user_rounded, color: AppColors.primary, size: 40),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Step 1 of 3',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  Text(
                    'Verify your medical licensing to start practicing online.',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildUploadItem(String title, String? status) {
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.cloud_upload_outlined;

    if (status == 'Verified') {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle_rounded;
    } else if (status == 'Pending') {
      statusColor = Colors.orange;
      statusIcon = Icons.hourglass_empty_rounded;
    }

    return FadeInUp(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(statusIcon, color: statusColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(
                    status ?? 'Click to upload PDF/Image',
                    style: TextStyle(color: statusColor, fontSize: 12, fontWeight: status != null ? FontWeight.bold : FontWeight.normal),
                  ),
                ],
              ),
            ),
            if (status == null)
              const Icon(Icons.add_a_photo_outlined, size: 20, color: AppColors.textHint)
            else
              const Icon(Icons.remove_red_eye_outlined, size: 20, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  Widget _buildPayoutSetupCard() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
          gradient: LinearGradient(
            colors: [Colors.white, AppColors.accent.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.account_balance_rounded, color: AppColors.primary, size: 30),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bank Details', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Set up bank for consultation payouts', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
            ),
            TextButton(onPressed: () {}, child: const Text('Add')),
          ],
        ),
      ),
    );
  }
}
