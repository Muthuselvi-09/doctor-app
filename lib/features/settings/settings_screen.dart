import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildSectionCard([
              _buildSwitchItem(Icons.notifications_active_outlined, 'Push Notifications', true),
              _buildSwitchItem(Icons.mark_email_unread_outlined, 'Email Reports', false),
              _buildSwitchItem(Icons.security_rounded, 'Biometric Login', true),
            ]),
            const SizedBox(height: 24),
            _buildSectionCard([
              _buildSettingsItem(Icons.language_rounded, 'App Language', 'English (US)'),
              _buildSettingsItem(Icons.dark_mode_outlined, 'Theme Mode', 'System Default'),
            ]),
            const SizedBox(height: 24),
            _buildSectionCard([
              _buildSettingsItem(Icons.lock_person_outlined, 'Privacy Settings', 'Manage your data visibility'),
              _buildSettingsItem(Icons.description_outlined, 'Terms of Service', 'Read our legal guidelines'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(List<Widget> items) {
    return FadeInUp(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Column(children: items),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, bool value) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: (v) {},
        activeColor: AppColors.primary,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
