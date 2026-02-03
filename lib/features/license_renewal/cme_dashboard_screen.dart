import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';
import 'domain/models/compliance_models.dart';
import 'presentation/providers/compliance_providers.dart';

class CMEDashboardScreen extends ConsumerWidget {
  const CMEDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cmeAsync = ref.watch(cmeProgressProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('CME Credits Management'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: cmeAsync.when(
        data: (cme) => _buildContent(context, cme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/revival-cme-upload'),
        backgroundColor: RevivalColors.navyBlue,
        icon: const Icon(Icons.upload_file_rounded, color: Colors.white),
        label: const Text('Upload Certificate', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildContent(BuildContext context, CMEProgress cme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgressCard(cme),
          const SizedBox(height: 32),
          _buildVerificationSummary(cme),
          const SizedBox(height: 32),
          const Text(
            'CME History (2025-2026)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 16),
          ...cme.entries.map((entry) => _buildCMEEntryTile(entry)),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProgressCard(CMEProgress cme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: RevivalColors.navyGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Credit Progression', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text(
                '${cme.totalCredits} / ${cme.requiredCredits}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: cme.percentage,
              minHeight: 12,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${(cme.requiredCredits - cme.totalCredits).toStringAsFixed(1)} credits remaining for compliance',
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSummary(CMEProgress cme) {
    final pendingCount = cme.entries.where((e) => e.status == DocumentStatus.pending).length;
    final verifiedCount = cme.entries.where((e) => e.status == DocumentStatus.verified).length;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryBox('Verified', verifiedCount.toString(), RevivalColors.activeGreen),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildSummaryBox('In Process', pendingCount.toString(), RevivalColors.expiringOrange),
        ),
      ],
    );
  }

  Widget _buildSummaryBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildCMEEntryTile(CMEEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: RevivalColors.softGrey, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.school_outlined, color: RevivalColors.navyBlue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.title, style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
                    const SizedBox(height: 4),
                    Text(
                      '${entry.date.day}/${entry.date.month}/${entry.date.year}  •  ${entry.credits} Credits',
                      style: const TextStyle(color: RevivalColors.darkGrey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (entry.status == DocumentStatus.verified ? RevivalColors.activeGreen : RevivalColors.expiringOrange).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  entry.status.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: (entry.status == DocumentStatus.verified ? RevivalColors.activeGreen : RevivalColors.expiringOrange),
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility_outlined, size: 16),
                label: const Text('View Cert', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(foregroundColor: RevivalColors.primaryBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
