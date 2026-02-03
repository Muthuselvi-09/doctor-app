import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/revival_colors.dart';
import 'package:doctor_app/features/license_renewal/domain/models/compliance_models.dart';
import 'package:doctor_app/features/license_renewal/presentation/providers/compliance_providers.dart';

class AdminVerificationHubScreen extends ConsumerWidget {
  const AdminVerificationHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(complianceDocumentsProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text('Admin Portal', style: TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold)),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        leading: BackButton(color: RevivalColors.navyBlue),
        actions: [
          _buildRoleBadge('SUPER ADMIN'),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAdminDashboardStats(),
            const SizedBox(height: 32),
            Text(
              'Queue: Pending Renewals',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
            ),
            const SizedBox(height: 16),
            _buildRenewalJobCard(
              name: 'Dr. Anya Sharma',
              license: 'Medical License Renewal',
              status: 'AWAITING VERIFICATION',
              statusColor: RevivalColors.pendingBlue,
              docs: documentsAsync,
            ),
            _buildRenewalJobCard(
              name: 'Dr. Rahul Mehta',
              license: 'Clinic License Renewal',
              status: 'APPLIED TO AUTHORITY',
              statusColor: RevivalColors.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBadge(String role) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: RevivalColors.navyBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          role,
          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildAdminDashboardStats() {
    return Row(
      children: [
        Expanded(child: _buildStatBox('Total Pending', '14', Icons.pending_actions_rounded)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatBox('Verified Today', '08', Icons.check_circle_rounded)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatBox('Expiring Alert', '03', Icons.warning_rounded)),
      ],
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: RevivalColors.navyBlue),
          const SizedBox(height: 12),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
          Text(label, style: TextStyle(fontSize: 11, color: RevivalColors.darkGrey)),
        ],
      ),
    );
  }

  Widget _buildRenewalJobCard({
    required String name,
    required String license,
    required String status,
    required Color statusColor,
    AsyncValue<List<LicenseDocument>>? docs,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundColor: RevivalColors.accent, child: Icon(Icons.person, color: RevivalColors.navyBlue)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: RevivalColors.navyBlue)),
                    Text(license, style: TextStyle(fontSize: 13, color: RevivalColors.darkGrey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (docs != null) docs.when(
            data: (dList) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vault Documents (Ready to verify)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: RevivalColors.navyBlue)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: dList.map((doc) => _buildAdminDocChip(doc)).toList(),
                ),
              ],
            ),
            loading: () => const CircularProgressIndicator(),
            error: (e, s) => Text('Error loading docs: $e'),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: RevivalColors.navyBlue,
                    side: BorderSide(color: RevivalColors.navyBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Full Profile'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RevivalColors.activeGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Action: Approve'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdminDocChip(LicenseDocument doc) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.description_outlined, size: 14, color: RevivalColors.navyBlue),
          const SizedBox(width: 8),
          Text(doc.name, style: TextStyle(fontSize: 11, color: RevivalColors.navyBlue)),
          const SizedBox(width: 8),
          Icon(Icons.check_circle_rounded, size: 14, color: doc.status == DocumentStatus.verified ? RevivalColors.activeGreen : RevivalColors.darkGrey.withOpacity(0.3)),
        ],
      ),
    );
  }
}
