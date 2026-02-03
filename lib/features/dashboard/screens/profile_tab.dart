import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            FadeInDown(
              child: Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: RevivalColors.navyBlue,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Dr. John Doe',
                      style: GoogleFonts.outfit(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: RevivalColors.deepNavy,
                      ),
                    ),
                    Text(
                      'Cardiologist',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: RevivalColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Stats
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(label: 'Applications', value: '12'),
                  _StatItem(label: 'Pending', value: '2', color: Colors.orange),
                  _StatItem(label: 'Approved', value: '10', color: Colors.green),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Menu
            _ProfileMenuItem(
              icon: Icons.track_changes,
              title: 'Application Status Tracker',
              delay: 300,
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.file_present_outlined,
              title: 'Uploaded Documents',
              delay: 400,
              onTap: () => context.push('/master-vault'),
            ),
            _ProfileMenuItem(
              icon: Icons.notifications_outlined,
              title: 'Notifications',
              delay: 500,
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.help_outline,
              title: 'Support & Help',
              delay: 600,
              onTap: () {},
            ),
             _ProfileMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              color: RevivalColors.danger,
              delay: 700,
              onTap: () => context.go('/role-selection'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _StatItem({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color ?? RevivalColors.deepNavy,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: RevivalColors.darkGrey,
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final int delay;
  final Color? color;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.delay,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color ?? RevivalColors.navyBlue),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color ?? RevivalColors.deepNavy,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right, color: RevivalColors.midGrey),
            ],
          ),
        ),
      ),
    );
  }
}
