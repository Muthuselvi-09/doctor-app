import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class WorkflowTrackerScreen extends StatelessWidget {
  const WorkflowTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Status Tracking'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildStatusHeader(),
            const SizedBox(height: 40),
            _buildTimeline(),
            const SizedBox(height: 48),
            _buildSupportAction(),
            const SizedBox(height: 20),
            _buildSimulateButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Text(
            'Application #DR-2024-88',
            style: TextStyle(fontSize: 14, color: RevivalColors.darkGrey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'In Progress',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: RevivalColors.navyBlue),
          ),
          SizedBox(height: 16),
          Text(
            'Estimated approval: 3-5 business days',
            style: TextStyle(fontSize: 13, color: RevivalColors.primaryBlue, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineStep('Documents Received', 'We have successfully received your files.', isCompleted: true, isFirst: true),
        _buildTimelineStep('Verification in Progress', 'Revival experts are auditing your documents.', isCompleted: true),
        _buildTimelineStep('Application Filed', 'Submitted to the respective Medical Council.', isInProgress: true),
        _buildTimelineStep('Govt. Review', 'Awaiting Council approval & signature.', isPending: true),
        _buildTimelineStep('Revival Approved', 'Final verified certificate issued.', isPending: true, isLast: true),
      ],
    );
  }

  Widget _buildTimelineStep(String title, String sub, {bool isCompleted = false, bool isInProgress = false, bool isPending = false, bool isFirst = false, bool isLast = false}) {
    Color dotColor = isCompleted ? RevivalColors.activeGreen : isInProgress ? RevivalColors.navyBlue : RevivalColors.midGrey;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? RevivalColors.activeGreen : RevivalColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: dotColor, width: 2),
              ),
              child: isCompleted ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
            if (!isLast) Container(width: 2, height: 40, color: isCompleted ? RevivalColors.activeGreen : RevivalColors.midGrey),
          ],
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isPending ? RevivalColors.darkGrey : RevivalColors.navyBlue, fontSize: 16)),
              const SizedBox(height: 4),
              Text(sub, style: TextStyle(color: RevivalColors.darkGrey, fontSize: 13, height: 1.4)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportAction() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.help_outline_rounded, color: RevivalColors.primaryBlue),
          SizedBox(width: 16),
          Expanded(child: Text('Need help? Chat with an expert', style: TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue))),
          Icon(Icons.chevron_right_rounded, color: RevivalColors.darkGrey),
        ],
      ),
    );
  }

  Widget _buildSimulateButton(BuildContext context) {
    return TextButton(
      onPressed: () => context.push('/revival-completion'),
      child: const Text('Simulate Approval (Demo)', style: TextStyle(color: RevivalColors.darkGrey, fontSize: 12)),
    );
  }
}
