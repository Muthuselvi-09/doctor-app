import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/revival_colors.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              FadeInDown(
                child: Text(
                  'Welcome to\nDoctor Revival',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.deepNavy,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Please select your role to continue',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ),
              const SizedBox(height: 60),

              // Admin Role Card
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: _RoleCard(
                  title: 'Admin',
                  description: 'Manage approvals, workflows & services',
                  icon: Icons.admin_panel_settings_outlined,
                  color: RevivalColors.primaryBlue,
                  onTap: () => context.go('/admin-login'),
                ),
              ),

              const SizedBox(height: 20),

              // User Role Card
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _RoleCard(
                  title: 'Healthcare Provider',
                  description: 'Doctors, Clinics & Hospitals',
                  icon: Icons.medical_services_outlined,
                  color: RevivalColors.navyBlue,
                  onTap: () => context.go('/login'),
                  isPrimary: true,
                ),
              ),
              
              const Spacer(),
              
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: Center(
                  child: Text(
                    'Need help? Contact Support',
                    style: GoogleFonts.outfit(
                      color: RevivalColors.verificationGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
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
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool isPrimary;

  const _RoleCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isPrimary ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(isPrimary ? 0.3 : 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          border: isPrimary ? null : Border.all(color: color.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isPrimary ? Colors.white.withOpacity(0.15) : color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isPrimary ? Colors.white : color,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isPrimary ? Colors.white : RevivalColors.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: isPrimary ? Colors.white.withOpacity(0.8) : RevivalColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isPrimary ? Colors.white.withOpacity(0.5) : RevivalColors.verificationGrey,
            ),
          ],
        ),
      ),
    );
  }
}
