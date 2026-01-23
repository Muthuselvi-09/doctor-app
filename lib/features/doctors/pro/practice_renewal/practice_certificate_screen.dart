import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class PracticeCertificateScreen extends StatelessWidget {
  const PracticeCertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Clinic Establishment License'),
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
            _buildLicenseDetails(),
            const SizedBox(height: 48),
            _buildActionButtons(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificatePreview() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.primary.withOpacity(0.1), width: 2),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Icon(Icons.security_rounded, color: AppColors.primary, size: 24),
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                   decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                   child: const Text('VALID', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
                 ),
               ],
             ),
             const SizedBox(height: 24),
             const Text(
               'CERTIFICATE OF RENEWAL',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
             ),
             const SizedBox(height: 8),
             const Text(
               'LICENSE NO: PRAC-EST-2024-91823',
               style: TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.bold),
             ),
             const SizedBox(height: 24),
             const Divider(height: 32),
             const Text('City Health Clinic', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary)),
             const SizedBox(height: 8),
             const Text('Lead Practitioner: Dr. Sarah Watson', style: TextStyle(fontSize: 14)),
             const SizedBox(height: 24),
             Container(
               width: 100,
               height: 100,
               decoration: BoxDecoration(
                 color: AppColors.background,
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(color: Colors.black.withOpacity(0.05)),
               ),
               child: const Icon(Icons.qr_code_2_rounded, size: 80, color: AppColors.textPrimary),
             ),
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseDetails() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: const Column(
          children: [
            _DetailRow(label: 'Date of Issue', value: 'Jan 22, 2026'),
            _DetailRow(label: 'Expiry Date', value: 'Jan 21, 2031'),
            _DetailRow(label: 'Council', value: 'National Medical Council'),
            _DetailRow(label: 'Primary Service', value: 'Multi-Specialty Care'),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Downloading digital license...')),
            );
          },
          icon: const Icon(Icons.file_download_outlined),
          label: const Text('Download Digital Copy (PDF)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () => context.push('/practice-reminder'),
          icon: const Icon(Icons.notification_add_outlined),
          label: const Text('Setup Future Reminders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: Colors.white.withOpacity(0.8),
            foregroundColor: AppColors.primary,
            elevation: 0,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
