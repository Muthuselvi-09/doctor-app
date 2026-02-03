import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class AdvanceReminderScreen extends StatefulWidget {
  const AdvanceReminderScreen({super.key});

  @override
  State<AdvanceReminderScreen> createState() => _AdvanceReminderScreenState();
}

class _AdvanceReminderScreenState extends State<AdvanceReminderScreen> {
  bool _emailReminders = true;
  bool _whatsappReminders = true;
  bool _pushReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Reminder Setup'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Schedule Renewal Alerts',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
            ),
            const SizedBox(height: 12),
            const Text(
              'Never miss a deadline. We will send you progressive reminders before your license expires.',
              style: TextStyle(fontSize: 14, color: RevivalColors.darkGrey, height: 1.5),
            ),
            const SizedBox(height: 40),
            _buildReminderOption(
              'Email Notifications',
              'Critical updates and renewal alerts',
              Icons.email_outlined,
              _emailReminders,
              (val) => setState(() => _emailReminders = val),
            ),
            const SizedBox(height: 16),
            _buildReminderOption(
              'WhatsApp Alerts',
              'Instant status tracking and reminders',
              Icons.chat_bubble_outline_rounded,
              _whatsappReminders,
              (val) => setState(() => _whatsappReminders = val),
            ),
            const SizedBox(height: 16),
            _buildReminderOption(
              'Push Notifications',
              'Real-time verification updates',
              Icons.notifications_active_outlined,
              _pushReminders,
              (val) => setState(() => _pushReminders = val),
            ),
            const SizedBox(height: 48),
            _buildTimelineSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildReminderOption(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: RevivalColors.primaryBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: RevivalColors.activeGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Automated Alert Timeline',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: RevivalColors.darkGrey),
        ),
        const SizedBox(height: 20),
        _buildTimelineItem('90 Days Before', 'Early bird renewal reminder', isCompleted: true),
        _buildTimelineItem('60 Days Before', 'Required documents final call', isCompleted: true),
        _buildTimelineItem('30 Days Before', 'Mandatory filing assistance', isCompleted: false),
      ],
    );
  }

  Widget _buildTimelineItem(String label, String sub, {required bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, size: 16, color: isCompleted ? RevivalColors.activeGreen : RevivalColors.darkGrey.withOpacity(0.3)),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isCompleted ? RevivalColors.navyBlue : RevivalColors.darkGrey)),
          const SizedBox(width: 8),
          Text('• $sub', style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
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
      child: ElevatedButton(
        onPressed: () => context.push('/revival-review-lock'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('Next: Review & Confirm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
