import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class PortalSelectionScreen extends StatelessWidget {
  const PortalSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              FadeInDown(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: RevivalColors.darkGrey,
                        fontSize: 16,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Doctor Revival',
                      style: TextStyle(
                        color: RevivalColors.navyBlue,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Select a portal to continue your workflow',
                      style: TextStyle(
                        color: RevivalColors.darkGrey,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              _buildPortalCard(
                context,
                title: 'Doctor Portal',
                subtitle: 'License renewals, document vault & clinical compliance tools.',
                icon: Icons.person_add_alt_1_rounded,
                color: RevivalColors.primaryBlue,
                index: 0,
                onTap: () => context.go('/revival-doctor-dashboard'),
              ),
              const SizedBox(height: 20),
              _buildPortalCard(
                context,
                title: 'Hospital & Clinic',
                subtitle: 'Institutional licenses, staff verification & facility compliance.',
                icon: Icons.business_rounded,
                color: const Color(0xFF00C2A8),
                index: 1,
                onTap: () => context.go('/hospital-placeholder'),
              ),
              const SizedBox(height: 20),
              _buildPortalCard(
                context,
                title: 'Pharmacy Network',
                subtitle: 'Drug license management, inventory compliance & registrations.',
                icon: Icons.local_pharmacy_rounded,
                color: Colors.orange,
                index: 2,
                onTap: () => context.go('/pharmacy-placeholder'),
              ),
              const SizedBox(height: 60),
              Center(
                child: FadeInUp(
                  delay: const Duration(milliseconds: 800),
                  child: Column(
                    children: [
                      Text(
                        'Doctor Revival • Integrated Compliance Platform',
                        style: TextStyle(
                          color: RevivalColors.darkGrey.withOpacity(0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton.icon(
                        onPressed: () => context.push('/admin-verification-hub'),
                        icon: const Icon(Icons.admin_panel_settings_outlined, size: 16, color: RevivalColors.primaryBlue),
                        label: const Text(
                          'Expert Admin Access',
                          style: TextStyle(
                            color: RevivalColors.primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          backgroundColor: RevivalColors.primaryBlue.withOpacity(0.05),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortalCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int index,
    required VoidCallback onTap,
  }) {
    return FadeInLeft(
      delay: Duration(milliseconds: 300 + (index * 150)),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: RevivalColors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: color.withOpacity(0.1),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.06),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: RevivalColors.navyBlue,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: RevivalColors.darkGrey,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: color.withOpacity(0.4),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
