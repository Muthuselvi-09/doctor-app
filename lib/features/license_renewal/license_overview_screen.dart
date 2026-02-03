import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';
import 'domain/models/compliance_models.dart';

class LicenseOverviewScreen extends StatelessWidget {
  const LicenseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, this would be fetched based on a service ID
    final service = LicenseService(
      id: 'med_renewal',
      title: 'Medical License Renewal',
      description: 'Medical council license renewal (MCI/SMC)',
      registrationNumber: 'MC-12345',
      medicalCouncil: 'State Medical Council',
      status: LicenseStatus.expiring,
      issueDate: DateTime(2021, 10, 24),
      expiryDate: DateTime(2026, 10, 24),
    );

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('License Overview'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroCard(service),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailSection(service),
                  const SizedBox(height: 32),
                  _buildStatusTimeline(service),
                  const SizedBox(height: 48),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard(LicenseService service) {
    Color statusColor = service.status == LicenseStatus.expiring ? RevivalColors.expiringOrange : RevivalColors.activeGreen;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 32, left: 24, right: 24, top: 20),
      decoration: const BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          FadeInDown(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_rounded, color: statusColor, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    service.status.name.toUpperCase(),
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            service.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 8),
          Text(
            service.medicalCouncil ?? 'Medical Council',
            style: const TextStyle(fontSize: 16, color: RevivalColors.darkGrey),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSimpleStat('Expiry Date', '${service.expiryDate?.day}/${service.expiryDate?.month}/${service.expiryDate?.year}'),
              Container(width: 1, height: 40, color: RevivalColors.softGrey),
              _buildSimpleStat('Reg. No', service.registrationNumber ?? 'N/A'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
      ],
    );
  }

  Widget _buildDetailSection(LicenseService service) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('License Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
        const SizedBox(height: 16),
        _buildDetailRow(Icons.history_rounded, 'Issue Date', '${service.issueDate?.day}/${service.issueDate?.month}/${service.issueDate?.year}'),
        _buildDetailRow(Icons.calendar_today_rounded, 'Validity', '5 Years'),
        _buildDetailRow(Icons.account_balance_rounded, 'Issuing Authority', service.medicalCouncil ?? 'N/A'),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: RevivalColors.primaryBlue),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: RevivalColors.darkGrey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: RevivalColors.navyBlue)),
        ],
      ),
    );
  }

  Widget _buildStatusTimeline(LicenseService service) {
    // This is just a static view for the overview screen
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Last Renewal', style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
          const SizedBox(height: 16),
          _buildTimelineStep('Renewed successfully', '24 Oct 2021', isCompleted: true),
          _buildTimelineStep('Next renewal due', '24 Oct 2026', isLast: true),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String title, String date, {bool isCompleted = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              isCompleted ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
              size: 20,
              color: isCompleted ? RevivalColors.activeGreen : RevivalColors.primaryBlue,
            ),
            if (!isLast) Container(width: 2, height: 30, color: RevivalColors.softGrey),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue, fontSize: 14)),
            Text(date, style: const TextStyle(color: RevivalColors.darkGrey, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.push('/revival-eligibility-rules'),
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Start Renewal Process', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () => context.push('/revival-renewal-history'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            side: const BorderSide(color: RevivalColors.navyBlue),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('View Renewal History', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
        ),
      ],
    );
  }
}
