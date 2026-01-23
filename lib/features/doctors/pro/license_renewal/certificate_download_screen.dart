import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class CertificateDownloadScreen extends StatelessWidget {
  const CertificateDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Download Certificate'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildCertificatePreview(),
            const SizedBox(height: 32),
            _buildDetailsCard(),
            const SizedBox(height: 48),
            _buildDownloadButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatePreview() {
    return FadeInDown(
      child: Container(
        height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
             BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
             const Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.verified_rounded, color: Colors.blue, size: 20),
                 SizedBox(width: 8),
                 Text('OFFICIAL MEDICAL LICENSE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2, color: Colors.blue)),
               ],
             ),
             const SizedBox(height: 32),
             const Text('RENEWAL CERTIFICATE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
             const Expanded(child: Center(child: Icon(Icons.description_rounded, size: 100, color: AppColors.primary))),
             const Divider(),
             const SizedBox(height: 16),
             const Text('Valid until: Oct 2031', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
             Text('License No: MD-12345-US', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: const Column(
          children: [
            _InfoRow(label: 'Doctor Name', value: 'Sarah Morgan'),
            _InfoRow(label: 'Reg Date', value: 'Jan 22, 2026'),
            _InfoRow(label: 'Council', value: 'National Medical Council'),
            _InfoRow(label: 'Ref No', value: '#REV-9821-X'),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF Downloaded to /Storage/Downloads')));
          },
          icon: const Icon(Icons.file_download_outlined),
          label: const Text('Download PDF Certificate'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => context.push('/reminder-scheduler'),
          icon: const Icon(Icons.notifications_active_outlined),
          label: const Text('Setup Reminders for Next Renewal'),
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label, value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
