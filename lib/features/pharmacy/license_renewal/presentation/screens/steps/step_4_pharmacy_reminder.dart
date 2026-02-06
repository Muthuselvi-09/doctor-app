import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/theme/revival_colors.dart';

class Step4PharmacyReminder extends StatefulWidget {
  const Step4PharmacyReminder({super.key});

  @override
  State<Step4PharmacyReminder> createState() => _Step4PharmacyReminderState();
}

class _Step4PharmacyReminderState extends State<Step4PharmacyReminder> {
  bool _emailEnabled = true;
  bool _whatsappEnabled = true;
  int _selectedFrequency = 30; // days

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [RevivalColors.navyBlue, Color(0xFF475569)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.alarm, color: Colors.white, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("License Expires On", style: GoogleFonts.outfit(color: Colors.white70, fontSize: 12)),
                      Text("12 Oct 2026", style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text("Reminder Channels", style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
          const SizedBox(height: 16),
          
          _buildSwitch("Email Notifications", "Get reminders via registered email", Icons.email, _emailEnabled, (v) => setState(() => _emailEnabled = v)),
          const SizedBox(height: 12),
          _buildSwitch("WhatsApp Alerts", "Get instant alerts on WhatsApp", Icons.chat, _whatsappEnabled, (v) => setState(() => _whatsappEnabled = v)),
          
          const SizedBox(height: 24),
          Text("Reminder Frequency", style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
          const SizedBox(height: 16),
          
          Wrap(
            spacing: 12,
            children: [
              _buildChoiceChip("30 Days Before", 30),
              _buildChoiceChip("15 Days Before", 15),
              _buildChoiceChip("7 Days Before", 7),
            ],
          ),
          
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: RevivalColors.softGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: RevivalColors.midGrey),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_month, color: RevivalColors.navyBlue),
                const SizedBox(width: 12),
                Expanded(
                  child: Text("Sync with Calendar", style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                ),
                Switch(value: true, onChanged: (v) {}, activeColor: RevivalColors.navyBlue),
              ],
            ),
          ),
           const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSwitch(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RevivalColors.midGrey.withOpacity(0.3)),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.darkGrey)),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: RevivalColors.softGrey, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: RevivalColors.navyBlue, size: 20),
        ),
        activeColor: RevivalColors.navyBlue,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
  
  Widget _buildChoiceChip(String label, int val) {
    bool isSelected = _selectedFrequency == val;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (v) => setState(() => _selectedFrequency = val),
      selectedColor: RevivalColors.navyBlue,
      labelStyle: TextStyle(color: isSelected ? Colors.white : RevivalColors.deepNavy),
      backgroundColor: Colors.white,
    );
  }
}
