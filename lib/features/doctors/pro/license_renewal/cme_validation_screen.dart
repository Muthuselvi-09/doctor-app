import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class CMEValidationScreen extends StatelessWidget {
  const CMEValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('CME Validation'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildGlassHeader(),
            const SizedBox(height: 32),
            _buildCMEBreakdown(),
            const SizedBox(height: 48),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 40),
            ),
            const SizedBox(height: 16),
            const Text('30 / 30 Hours', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
            Text('Validated & Verified', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCMEBreakdown() {
    final items = [
      {'title': 'National Medical Conf 2025', 'hours': '12 Hours', 'type': 'Category 1'},
      {'title': 'Online Ethics Workshop', 'hours': '4 Hours', 'type': 'Category 2'},
      {'title': 'Research Publication - AI', 'hours': '10 Hours', 'type': 'Category 1'},
      {'title': 'Soft Skills Seminar', 'hours': '4 Hours', 'type': 'Category 2'},
    ];

    return Column(
      children: items.map((item) => FadeInUp(
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                   Text(item['type']!, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
              Text(item['hours']!, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.push('/submission-review'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('Proceed to Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
