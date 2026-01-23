import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class InspectionTrackingScreen extends StatelessWidget {
  const InspectionTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Inspection Tracking'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildUpcomingVisitCard(),
            const SizedBox(height: 32),
            _buildSectionTitle('Inspection Timeline'),
            const SizedBox(height: 16),
            _buildTimeline(),
            const SizedBox(height: 48),
            _buildActionButtons(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingVisitCard() {
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
              radius: 36,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Inspection Scheduled',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'A Health Department officer will visit your premises.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.event_available_rounded, color: AppColors.primary, size: 20),
                   SizedBox(width: 12),
                   Text('Jan 29, 2026 | 11:00 AM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FadeInLeft(
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            _buildTimelineStep('Payment Verified', 'Jan 22, 2:30 PM', 'License fee ₹25,000 received', true),
            _buildTimelineStep('Officer Assigned', 'Jan 22, 4:00 PM', 'Dr. Rajesh Sharma (Health Inspector)', true),
            _buildTimelineStep('Inspection Visit', 'Jan 29, 11:00 AM', 'On-site clinical verification', false, isActive: true),
            _buildTimelineStep('Report Generation', '--', 'Documenting inspection findings', false),
            _buildTimelineStep('Final Approval', '--', 'Issuance of practice license', false, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, String time, String desc, bool isCompleted, {bool isActive = false, bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : (isActive ? AppColors.primary : Colors.grey[300]),
                shape: BoxShape.circle,
                border: isActive ? Border.all(color: Colors.white, width: 3) : null,
              ),
              child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 10) : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: isCompleted ? Colors.green.withOpacity(0.3) : Colors.grey[200],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isActive ? AppColors.primary : AppColors.textPrimary)),
                  Text(time, style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 4),
              Text(desc, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.push('/practice-status'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text('View Application Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {},
          child: const Text('Reschedule Visit (Emergency Only)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
        ),
      ],
    );
  }
}
