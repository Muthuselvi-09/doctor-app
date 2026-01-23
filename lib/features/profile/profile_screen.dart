import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildSectionCard([
                    _buildSettingsItem(Icons.person_outline_rounded, 'My Account', 'Edit personal information'),
                    _buildSettingsItem(Icons.history_rounded, 'Appointments', 'History and upcoming sessions'),
                    _buildSettingsItem(Icons.description_outlined, 'Health Records', 'Vault and reports', onTap: () => context.push('/health-records')),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionCard([
                    _buildSettingsItem(Icons.payment_rounded, 'Payments', 'Cards, UPI and Wallets'),
                    _buildSettingsItem(Icons.group_outlined, 'Dependents', 'Manage family members'),
                    _buildSettingsItem(Icons.language_rounded, 'Languages', 'Change app language'),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionCard([
                    _buildSettingsItem(Icons.settings_outlined, 'Settings', 'Notifications, Language, Privacy', onTap: () => context.push('/settings')),
                    _buildSettingsItem(Icons.help_outline_rounded, 'Help & Support', 'FAQs and contact us'),
                    _buildSettingsItem(Icons.privacy_tip_outlined, 'Privacy Policy', 'Data usage and security'),
                    _buildSettingsItem(Icons.logout_rounded, 'Logout', 'Sign out from this device', isCritical: true),
                  ]),
                  const SizedBox(height: 32),
                  const Text('Doctor Revival v1.0.0', style: TextStyle(color: AppColors.textHint, fontSize: 12)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                ),
                child: const CircleAvatar(
                  backgroundColor: AppColors.accent,
                  child: Icon(Icons.person, size: 60, color: AppColors.primary),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt_rounded, size: 20, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Dr. Alex Morgan',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text(
            'Chief Medical Officer • Cardialogy',
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            'License No: MD-12345-US',
            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
          ),
          const SizedBox(height: 16),
          const Text(
            'alex.morgan@hospital.com',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
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

  Widget _buildSettingsItem(IconData icon, String title, String subtitle, {VoidCallback? onTap, bool isCritical = false}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isCritical ? Colors.red.withOpacity(0.1) : AppColors.accent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isCritical ? Colors.red : AppColors.primary, size: 24),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isCritical ? Colors.red : AppColors.textPrimary)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
