import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:flutter/material.dart';

class Step4ReminderSetup extends StatefulWidget {
  const Step4ReminderSetup({super.key});

  @override
  State<Step4ReminderSetup> createState() => _Step4ReminderSetupState();
}

class _Step4ReminderSetupState extends State<Step4ReminderSetup> {
  bool _emailEnabled = true;
  bool _whatsappEnabled = true;

  int _selectedFrequencyIndex = 0;
  final List<String> _frequencies = ['30 Days Before', '15 Days Before', '7 Days Before'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Reminder Setup"),
          const SizedBox(height: 8),
          const Text(
            "Never miss a renewal deadline. We will remind you automatically.",
            style: TextStyle(color: RevivalColors.darkGrey),
          ),
          
          const SizedBox(height: 24),
          _buildInfoCard(),
          
          const SizedBox(height: 24),
          _buildLabel("Communication Channels"),
          _buildSwitchTile(
            title: "Email Reminder",
            subtitle: "Send reminders to registered email",
            icon: Icons.email_outlined,
            value: _emailEnabled,
            onChanged: (val) => setState(() => _emailEnabled = val),
          ),
          const SizedBox(height: 12),
          _buildSwitchTile(
            title: "WhatsApp Reminder",
            subtitle: "Send reminders to registered mobile",
            icon: Icons.chat_bubble_outline,
            value: _whatsappEnabled,
            onChanged: (val) => setState(() => _whatsappEnabled = val),
          ),

          const SizedBox(height: 24),
          _buildLabel("Reminder Frequency"),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(_frequencies.length, (index) {
              final isSelected = _selectedFrequencyIndex == index;
              return ChoiceChip(
                label: Text(_frequencies[index]),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFrequencyIndex = index;
                  });
                },
                selectedColor: RevivalColors.primaryBlue,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : RevivalColors.navyBlue,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: RevivalColors.softGrey,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }),
          ),

          const SizedBox(height: 32),
          // Google Calendar Integration (Visual)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: RevivalColors.midGrey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.calendar_month, color: Colors.blue),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sync with Google Calendar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RevivalColors.navyBlue,
                        ),
                      ),
                      Text(
                        "Add renewal dates to your calendar",
                        style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                      ),
                    ],
                  ),
                ),
                Switch(value: false, onChanged: (val) {}), // Visual only
              ],
            ),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: RevivalColors.navyBlue,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 3,
          color: RevivalColors.primaryBlue,
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: RevivalColors.navyBlue,
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.navyBlue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.shield, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "License Expiry",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "31st December 2026",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: RevivalColors.navyBlue)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey)),
        secondary: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: RevivalColors.softGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: RevivalColors.primaryBlue)),
        activeColor: RevivalColors.primaryBlue,
      ),
    );
  }
}
