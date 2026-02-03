import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ReminderSchedulerScreen extends StatefulWidget {
  const ReminderSchedulerScreen({super.key});

  @override
  State<ReminderSchedulerScreen> createState() => _ReminderSchedulerScreenState();
}

class _ReminderSchedulerScreenState extends State<ReminderSchedulerScreen> {
  final String _frequency = 'Monthly';
  final TimeOfDay _notificationTime = const TimeOfDay(hour: 9, minute: 0);
  bool _sendToAdmin = false;
  final Map<String, bool> _channels = {
    'Push Notification': true,
    'WhatsApp': false,
    'SMS': false,
    'Email': true,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Next Renewal Reminders'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFrequencySelector(),
            const SizedBox(height: 32),
            _buildTimeSelector(),
            const SizedBox(height: 32),
            const Text('Notification Channels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            _buildChannelGrid(),
            const SizedBox(height: 32),
            _buildInfoCard(),
            const SizedBox(height: 48),
            _buildActionButtons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRenewalDateInfo() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.event_note_rounded, color: Colors.orange, size: 28),
            ),
            const SizedBox(width: 16),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('License Expiry', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                Text('Oct 24, 2026', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildFrequencySelector() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            const Text('Notification Frequency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFreqOp('Monthly', Icons.calendar_month_rounded, false),
                _buildFreqOp('Weekly', Icons.view_week_rounded, true),
                _buildFreqOp('Daily', Icons.today_rounded, false),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFreqOp(String label, IconData icon, bool isActive) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.background.withOpacity(0.5),
            shape: BoxShape.circle,
            border: isActive ? null : Border.all(color: AppColors.primary.withOpacity(0.1)),
          ),
          child: Icon(icon, color: isActive ? Colors.white : AppColors.primary),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             const Row(
               children: [
                 Icon(Icons.access_time_filled_rounded, color: AppColors.primary),
                 SizedBox(width: 12),
                 Text('Preferred Time', style: TextStyle(fontWeight: FontWeight.bold)),
               ],
             ),
             Text('09:00 AM', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Widget _buildChannelGrid() {
    final channels = [
      {'name': 'Push Notification', 'icon': Icons.notifications_active_rounded, 'active': true},
      {'name': 'WhatsApp', 'icon': Icons.chat_bubble_rounded, 'active': true},
      {'name': 'SMS Alert', 'icon': Icons.sms_rounded, 'active': false},
      {'name': 'Email Digest', 'icon': Icons.email_rounded, 'active': false},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: channels.length,
      itemBuilder: (context, index) {
        final c = channels[index];
        bool isActive = c['active'] as bool;
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isActive ? 0.9 : 0.6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isActive ? AppColors.primary.withOpacity(0.3) : Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(c['icon'] as IconData, color: isActive ? AppColors.primary : AppColors.textHint, size: 28),
                const SizedBox(height: 8),
                Text(c['name'] as String, style: TextStyle(fontSize: 12, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdminSyncToggle() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send Updates to Clinic Admin', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Copy reminders to the secondary contact/manager.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Switch.adaptive(
            value: _sendToAdmin,
            onChanged: (val) => setState(() => _sendToAdmin = val),
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 28),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Reminders are synced with your system calendar and will also notify your administrative contacts.',
                style: TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Next renewal reminders scheduled successfully!')),
            );
            context.go('/doctor-dashboard');
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 64),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: const Text('Save & Finish', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.push('/additional-contact'),
          child: const Text('Add Staff for Backup Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
