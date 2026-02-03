import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';
import 'package:doctor_app/features/license_renewal/domain/models/compliance_models.dart';
import 'package:doctor_app/features/license_renewal/presentation/providers/compliance_providers.dart';

class DoctorDashboardScreen extends ConsumerWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(licenseServicesProvider);
    final cmeAsync = ref.watch(cmeProgressProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: const Text('Doctor Portal'),
        backgroundColor: RevivalColors.white,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: RevivalColors.navyBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded, color: RevivalColors.navyBlue),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileSummary(),
            const SizedBox(height: 24),
            _buildMasterVaultCard(context),
            const SizedBox(height: 24),
            _buildCMETrackerTile(cmeAsync),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'License & Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.navyBlue,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All', style: TextStyle(color: RevivalColors.primaryBlue)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            servicesAsync.when(
              data: (services) => Column(
                children: services.map((service) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildLicenseCard(
                    context,
                    service: service,
                    onTap: () {
                      if (service.status == LicenseStatus.pendingSubmission) {
                        context.push('/revival-service-overview');
                      } else {
                        context.push('/revival-workflow-tracker');
                      }
                    },
                  ),
                )).toList(),
              ),
              loading: () => const Center(child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              )),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
            const SizedBox(height: 32),
            _buildServiceSupportCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMasterVaultCard(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/revival-master-vault'),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: RevivalColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: RevivalColors.primaryBlue.withOpacity(0.2), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: RevivalColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.folder_shared_rounded, color: RevivalColors.primaryBlue, size: 28),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Master Document Vault',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RevivalColors.navyBlue,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'One-time upload for all renewals',
                    style: TextStyle(fontSize: 13, color: RevivalColors.darkGrey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: RevivalColors.primaryBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildCMETrackerTile(AsyncValue<CMEProgress> cmeAsync) {
    return cmeAsync.when(
      data: (cme) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: RevivalColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CME Credits Status',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.navyBlue,
                  ),
                ),
                Text(
                  '${cme.totalCredits.toStringAsFixed(1)} / ${cme.requiredCredits.toInt()} Credits',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: RevivalColors.primaryBlue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: cme.percentage,
                minHeight: 8,
                backgroundColor: RevivalColors.softGrey,
                valueColor: const AlwaysStoppedAnimation<Color>(RevivalColors.primaryBlue),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(cme.percentage * 100).toInt()}% towards compliance',
                  style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Update Certificates',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: RevivalColors.primaryBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      loading: () => Container(
        height: 120,
        decoration: BoxDecoration(
          color: RevivalColors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, s) => const SizedBox.shrink(),
    );
  }

  Widget _buildProfileSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: RevivalColors.navyGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: RevivalColors.navyBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: RevivalColors.white,
            child: Icon(Icons.person, color: RevivalColors.navyBlue, size: 35),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Doctor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your personal compliance assistant',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseCard(
    BuildContext context, {
    required LicenseService service,
    VoidCallback? onTap,
  }) {
    Color statusColor;
    String statusLabel;

    switch (service.status) {
      case LicenseStatus.active:
        statusColor = RevivalColors.activeGreen;
        statusLabel = 'ACTIVE';
        break;
      case LicenseStatus.expiring:
        statusColor = RevivalColors.expiringOrange;
        statusLabel = 'EXPIRING SOON';
        break;
      case LicenseStatus.expired:
        statusColor = RevivalColors.expiredRed;
        statusLabel = 'EXPIRED';
        break;
      case LicenseStatus.underVerification:
        statusColor = RevivalColors.verificationGrey;
        statusLabel = 'VERIFYING';
        break;
      case LicenseStatus.appliedToAuthority:
        statusColor = RevivalColors.primaryBlue;
        statusLabel = 'APPLIED';
        break;
      case LicenseStatus.approvedByAuthority:
        statusColor = RevivalColors.activeGreen;
        statusLabel = 'APPROVED';
        break;
      case LicenseStatus.correctionRequired:
        statusColor = RevivalColors.warning;
        statusLabel = 'ACTION NEEDED';
        break;
      case LicenseStatus.pendingSubmission:
        statusColor = RevivalColors.darkGrey;
        statusLabel = 'NOT STARTED';
        break;
      default:
        statusColor = RevivalColors.darkGrey;
        statusLabel = 'UNKNOWN';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: RevivalColors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: (service.status == LicenseStatus.expiring || service.status == LicenseStatus.expired)
                ? statusColor.withOpacity(0.3)
                : RevivalColors.navyBlue.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
                Icon(
                  service.status == LicenseStatus.pendingSubmission
                      ? Icons.add_circle_outline_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: RevivalColors.navyBlue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              service.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: RevivalColors.navyBlue,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              service.description,
              style: const TextStyle(
                fontSize: 14,
                color: RevivalColors.darkGrey,
              ),
            ),
            if (service.expiryDate != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 12, color: statusColor),
                  const SizedBox(width: 4),
                  Text(
                    'Expires on: ${service.expiryDate!.day}/${service.expiryDate!.month}/${service.expiryDate!.year}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildServiceSupportCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.navyBlue.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: RevivalColors.white, shape: BoxShape.circle),
            child: const Icon(Icons.support_agent_rounded, color: RevivalColors.navyBlue),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expert Assistance',
                  style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
                ),
                Text(
                  'Speak with our license specialist',
                  style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: RevivalColors.navyBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              minimumSize: const Size(0, 36),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Contact', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
