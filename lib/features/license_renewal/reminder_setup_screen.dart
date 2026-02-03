import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class ReminderSetupScreen extends StatefulWidget {
  const ReminderSetupScreen({super.key});

  @override
  State<ReminderSetupScreen> createState() => _ReminderSetupScreenState();
}

class _ReminderSetupScreenState extends State<ReminderSetupScreen> {
  DateTime? _expiryDate;
  final List<bool> _selections = [true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        title: const Text('Reminder Setup'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
        ),
        titleTextStyle: const TextStyle(
          color: RevivalColors.navyBlue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('License Expiry Date'),
            _buildDatePicker(),
            const SizedBox(height: 32),
            _buildSectionTitle('Reminder Notifications'),
            const Text(
              'Select when you want to be notified before the license expires.',
              style: TextStyle(fontSize: 14, color: RevivalColors.darkGrey),
            ),
            const SizedBox(height: 24),
            _buildReminderOption(0, '90 days before expiry'),
            _buildReminderOption(1, '60 days before expiry'),
            _buildReminderOption(2, '30 days before expiry'),
            const SizedBox(height: 40),
            _buildInfoBox(),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.push('/revival-review-lock'),
              style: ElevatedButton.styleFrom(
                backgroundColor: RevivalColors.navyBlue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: RevivalColors.navyBlue,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(days: 365)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 3650)),
        );
        if (date != null) {
          setState(() => _expiryDate = date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: RevivalColors.softGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_rounded, color: RevivalColors.navyBlue, size: 20),
            const SizedBox(width: 16),
            Text(
              _expiryDate == null
                  ? 'Select Expiry Date'
                  : '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}',
              style: TextStyle(
                color: _expiryDate == null ? RevivalColors.darkGrey : RevivalColors.navyBlue,
                fontSize: 16,
                fontWeight: _expiryDate == null ? FontWeight.normal : FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down_rounded, color: RevivalColors.navyBlue),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderOption(int index, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _selections[index] ? RevivalColors.navyBlue.withOpacity(0.3) : RevivalColors.midGrey,
        ),
      ),
      child: CheckboxListTile(
        value: _selections[index],
        onChanged: (val) => setState(() => _selections[index] = val!),
        activeColor: RevivalColors.navyBlue,
        title: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: _selections[index] ? RevivalColors.navyBlue : RevivalColors.darkGrey,
            fontWeight: _selections[index] ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.accent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(Icons.auto_awesome_rounded, color: RevivalColors.navyBlue),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'We track expiry and start renewal automatically based on your preferences.',
              style: TextStyle(
                fontSize: 14,
                color: RevivalColors.navyBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
