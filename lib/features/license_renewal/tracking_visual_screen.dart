import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class TrackingVisualScreen extends StatelessWidget {
  const TrackingVisualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Renewal Tracking'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildTrackingHeader(),
            const SizedBox(height: 32),
            _buildTimeline(),
            const SizedBox(height: 48),
            _buildInfoCard(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildTrackingHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Service ID:', style: TextStyle(color: RevivalColors.darkGrey, fontSize: 13)),
              Text('#REV-9921-MBBS', style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue, fontSize: 13)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('License:', style: TextStyle(color: RevivalColors.darkGrey, fontSize: 13)),
              Text('Medical License Renewal', style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          _buildStageTile('Documents received', '24 Oct 2026, 10:30 AM', isCompleted: true),
          _buildStageTile('Under verification', 'Our team is reviewing your documents', isCurrent: true),
          _buildStageTile('Applied to authority', 'Government portal submission'),
          _buildStageTile('Approved', 'Confirmation from council'),
          _buildStageTile('Certificate uploaded', 'Final certificate issued', isLast: true),
        ],
      ),
    );
  }

  Widget _buildStageTile(String title, String subtitle, {bool isCompleted = false, bool isCurrent = false, bool isLast = false}) {
    Color primaryColor = isCompleted ? RevivalColors.activeGreen : (isCurrent ? RevivalColors.primaryBlue : RevivalColors.darkGrey.withOpacity(0.3));
    
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted || isCurrent ? primaryColor.withOpacity(0.1) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor, width: 2),
                ),
                child: isCompleted 
                    ? Icon(Icons.check, size: 14, color: primaryColor)
                    : (isCurrent ? Center(child: Container(width: 8, height: 8, decoration: BoxDecoration(color: primaryColor, shape: BoxShape.circle))) : null),
              ),
              if (!isLast) Expanded(child: Container(width: 2, color: primaryColor.withOpacity(0.3))),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isCurrent || isCompleted ? RevivalColors.navyBlue : RevivalColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: isCurrent ? RevivalColors.primaryBlue : RevivalColors.darkGrey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RevivalColors.primaryBlue.withOpacity(0.1)),
      ),
      child: const Row(
        children: [
          Icon(Icons.access_time_filled_rounded, color: RevivalColors.primaryBlue, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Renewal typically takes 10-15 business days after successful verification.',
              style: TextStyle(fontSize: 13, color: RevivalColors.navyBlue, height: 1.4, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: OutlinedButton(
        onPressed: () => context.push('/revival-doctor-dashboard'),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          side: const BorderSide(color: RevivalColors.navyBlue),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Back to Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
      ),
    );
  }
}
