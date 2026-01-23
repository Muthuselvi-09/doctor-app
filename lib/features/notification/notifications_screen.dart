import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all read'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: 5,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: 100 * index),
            child: _buildNotificationItem(index),
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(int index) {
    final notifications = [
      {
        'title': 'Appointment Confirmed',
        'desc': 'Your appointment with Dr. Sarah Johnson is confirmed for tomorrow.',
        'time': '2m ago',
        'icon': Icons.event_available_rounded,
        'color': Colors.green,
      },
      {
        'title': 'Medicine Reminder',
        'desc': 'It is time to take your Paracetamol 500mg.',
        'time': '1h ago',
        'icon': Icons.medication_rounded,
        'color': Colors.orange,
      },
      {
        'title': 'Lab Report Ready',
        'desc': 'Your Blood Test results are now available in the vault.',
        'time': '3h ago',
        'icon': Icons.biotech_rounded,
        'color': Colors.blue,
      },
      {
        'title': 'Payment Successful',
        'desc': 'Transaction of \$50 for consultation was successful.',
        'time': '5h ago',
        'icon': Icons.account_balance_wallet_rounded,
        'color': Colors.purple,
      },
      {
        'title': 'System Update',
        'desc': 'Update to MediSuper v2.0 for better health insights.',
        'time': '1d ago',
        'icon': Icons.system_update_rounded,
        'color': Colors.grey,
      },
    ];

    final item = notifications[index % notifications.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (item['color'] as Color).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(item['time'] as String, style: const TextStyle(color: AppColors.textHint, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['desc'] as String,
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
