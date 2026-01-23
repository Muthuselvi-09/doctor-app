import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class RenewalTrackingScreen extends StatelessWidget {
  const RenewalTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('License Lifecycle'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentStatusCard(context),
            const SizedBox(height: 32),
            _buildSectionTitle('Compliance Timeline'),
            const SizedBox(height: 24),
            _buildVerticalTimeline(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStatusCard(BuildContext context) {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.hourglass_bottom_rounded, color: AppColors.primary, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              'Application Pending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            Text(
              'Your renewal is being reviewed by the Medical Council. Check back in 2-3 business days.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.push('/certificate-download'),
              icon: const Icon(Icons.verified_user_rounded),
              label: const Text('View & Download Certificate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.withOpacity(0.1),
                foregroundColor: Colors.green,
                elevation: 0,
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildVerticalTimeline() {
    final events = [
      {'title': 'License Issued', 'date': 'Oct 24, 2021', 'status': 'completed', 'desc': 'Initial registration approved.'},
      {'title': 'Verified for Renewal', 'date': 'Jan 15, 2026', 'status': 'completed', 'desc': 'Documents verified by clinic admin.'},
      {'title': 'Renewal Submitted', 'date': 'Jan 22, 2026', 'status': 'active', 'desc': 'Application under review by council.'},
      {'title': 'Approval Expected', 'date': 'Feb 10, 2026', 'status': 'pending', 'desc': 'Awaiting council decision.'},
      {'title': 'New Expiry Date', 'date': 'Oct 24, 2031', 'status': 'pending', 'desc': 'Projected validity period.'},
    ];

    return Column(
      children: List.generate(events.length, (index) {
        final event = events[index];
        return _buildTimelineStep(
          event['title']!,
          event['date']!,
          event['desc']!,
          event['status']!,
          isLast: index == events.length - 1,
        );
      }),
    );
  }

  Widget _buildTimelineStep(String title, String date, String desc, String status, {bool isLast = false}) {
    Color pointColor;
    Color lineColor;
    double dotSize = 16;
    FontWeight titleWeight = FontWeight.bold;

    switch (status) {
      case 'completed':
        pointColor = Colors.green;
        lineColor = Colors.green.withOpacity(0.3);
        break;
      case 'active':
        pointColor = AppColors.primary;
        lineColor = AppColors.primary.withOpacity(0.3);
        dotSize = 20;
        break;
      default:
        pointColor = Colors.grey[300]!;
        lineColor = Colors.grey[200]!;
        titleWeight = FontWeight.w500;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: pointColor,
                  shape: BoxShape.circle,
                  border: status == 'active' ? Border.all(color: Colors.white, width: 3) : null,
                  boxShadow: status == 'active' ? [BoxShadow(color: pointColor.withOpacity(0.4), blurRadius: 10)] : null,
                ),
                child: status == 'active' ? const Icon(Icons.sync_rounded, color: Colors.white, size: 10) : null,
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 60, // Fixed height for timeline segment instead of Expanded
                  color: lineColor,
                ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: FadeInRight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(title, style: TextStyle(fontWeight: titleWeight, fontSize: 15, color: status == 'pending' ? Colors.grey : AppColors.textPrimary)),
                       Text(date, style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                   const SizedBox(height: 4),
                   Text(desc, style: TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.4)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
