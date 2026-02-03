import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/license_renewal/logic/renewal_flow_coordinator.dart';

class DoctorPortalTab extends StatelessWidget {
  const DoctorPortalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doctor Portal',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: RevivalColors.deepNavy,
                        ),
                      ),
                      Text(
                        'Manage your medical credentials',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: RevivalColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: RevivalColors.primaryBlue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Renewals Section
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'License Renewals',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RevivalColors.deepNavy,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: _ServiceCard(
                title: 'Medical License',
                subtitle: 'Renew your medical practice license',
                icon: Icons.badge_outlined,
                color: Colors.blueAccent,
                onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Medical License'),
              ),
            ),
            const SizedBox(height: 12),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: _ServiceCard(
                title: 'Practice License',
                subtitle: 'Certificate of practice renewal',
                icon: Icons.local_hospital_outlined,
                color: Colors.teal,
                onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Practice License'),
              ),
            ),
            const SizedBox(height: 12),
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: _ServiceCard(
                title: 'Speciality License',
                subtitle: 'Update your specialization status',
                icon: Icons.stars_outlined,
                color: Colors.purple,
                onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Speciality License'),
              ),
            ),
            const SizedBox(height: 12),
            FadeInUp(
              delay: const Duration(milliseconds: 550),
              child: _ServiceCard(
                title: 'Clinic License',
                subtitle: 'Clinical establishment registration',
                icon: Icons.storefront_outlined,
                color: Colors.cyan,
                onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Clinic License'),
              ),
            ),
            const SizedBox(height: 12),
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: _ServiceCard(
                title: 'Hospital License',
                subtitle: 'Hospital operational license renewal',
                icon: Icons.local_hospital,
                color: Colors.red,
                onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Hospital License'),
              ),
            ),
            const SizedBox(height: 12),
            FadeInUp(
              delay: const Duration(milliseconds: 650),
              child: _ServiceCard(
                title: 'Medical Indemnity Insurance',
                subtitle: 'Professional liability insurance',
                icon: Icons.shield_outlined,
                color: Colors.amber,
                onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Medical Indemnity Insurance'),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Other Services
            FadeInUp(
              delay: const Duration(milliseconds: 700),
              child: Text(
                'Essential Services',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RevivalColors.deepNavy,
                ),
              ),
            ),
            const SizedBox(height: 16),
             FadeInUp(
              delay: const Duration(milliseconds: 750),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _GridServiceCard(
                    title: 'Indemnity\nInsurance',
                    icon: Icons.security,
                    color: Colors.orange,
                    onTap: () => RenewalFlowCoordinator.startRenewal(context, 'Medical Indemnity Insurance'),
                  ),
                  _GridServiceCard(
                    title: 'CME Credits\nManagement',
                    icon: Icons.school_outlined,
                    color: Colors.indigo,
                    onTap: () => RenewalFlowCoordinator.startRenewal(context, 'CME Credits'),
                  ),
                  _GridServiceCard(
                    title: 'E-Prescription\nEnablement',
                    icon: Icons.edit_note,
                    color: Colors.green,
                    onTap: () => RenewalFlowCoordinator.startRenewal(context, 'E-Prescription'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: RevivalColors.deepNavy,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: RevivalColors.darkGrey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: RevivalColors.midGrey),
          ],
        ),
      ),
    );
  }
}

class _GridServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _GridServiceCard({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: RevivalColors.deepNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
