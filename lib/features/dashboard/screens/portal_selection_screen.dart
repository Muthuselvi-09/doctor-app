import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class PortalSelectionScreen extends StatelessWidget {
  const PortalSelectionScreen({super.key});

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
              const SizedBox(height: 20),
              FadeInDown(
                child: Text(
                  'Welcome to',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Doctor Revival',
                  style: GoogleFonts.outfit(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.deepNavy,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                child: Text(
                  'Select a portal to continue your workflow',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: RevivalColors.darkGrey,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Doctor Portal Card
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: _PortalCard(
                  title: 'Doctor Portal',
                  description: 'License renewals, document vault & clinical compliance tools.',
                  icon: Icons.person_add_alt_1_rounded,
                  color: const Color(0xFFE3F2FD), // Light Blue
                  iconColor: RevivalColors.navyBlue,
                  onTap: () => context.go('/user-dashboard', extra: 0), // Index 0 for Doctor Tab
                ),
              ),

              const SizedBox(height: 24),

              // Hospital & Clinic Card
              FadeInUp(
                delay: const Duration(milliseconds: 700),
                child: _PortalCard(
                  title: 'Hospital & Clinic',
                  description: 'Institutional licenses, staff verification & facility compliance.',
                  icon: Icons.apartment_rounded,
                  color: const Color(0xFFE0F2F1), // Light Teal
                  iconColor: Colors.teal,
                  onTap: () => context.go('/user-dashboard', extra: 1), // Index 1 for Hospital Tab
                ),
              ),

              const SizedBox(height: 24),

              // Pharmacy Network Card
              FadeInUp(
                delay: const Duration(milliseconds: 800),
                child: _PortalCard(
                  title: 'Pharmacy Network',
                  description: 'Drug license management, inventory compliance & registrations.',
                  icon: Icons.local_pharmacy_rounded,
                  color: const Color(0xFFFFF3E0), // Light Orange
                  iconColor: Colors.orange,
                  onTap: () {
                    // Navigate to pharmacy or show placeholder
                     // For now, we can route to a generic placeholder or keep it on dashboard if implemented
                     // Assuming no specific pharmacy tab yet, maybe same dashboard but new tab?
                     // I will route to dashboard index 2 if I add it, or just show a snackbar/placeholder route.
                     // The user image shows it exists. I'll route to a placeholder route.
                     context.go('/user-dashboard', extra: 2); // Index 2 for Pharmacy Tab
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortalCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _PortalCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: iconColor,
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
                      color: RevivalColors.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: RevivalColors.darkGrey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.chevron_right_rounded,
                color: RevivalColors.midGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
