import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class MasterVaultScreen extends StatelessWidget {
  const MasterVaultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.deepNavy),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Master Document Vault',
          style: GoogleFonts.outfit(
            color: RevivalColors.deepNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_rounded, color: RevivalColors.deepNavy),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Banner
            FadeInDown(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD), // Light blue similar to image
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.withOpacity(0.1)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline_rounded, color: RevivalColors.navyBlue),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Documents in this vault are reused for all your license renewals and compliance needs.',
                        style: GoogleFonts.outfit(
                          color: RevivalColors.deepNavy,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Identity Section
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Identity',
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
              child: const _DocumentCard(
                title: 'Government ID Proof',
                date: '29/12/2024',
                isVerified: true,
                usedFor: ['MED RENEWAL', 'PRACTICE RENEWAL', 'CLINIC RENEWAL'],
                icon: Icons.description_outlined,
              ),
            ),
            const SizedBox(height: 16),
             FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: const _DocumentCard(
                title: 'Passport Size Photo',
                date: '25/10/2025',
                isVerified: true,
                usedFor: ['MED RENEWAL', 'PRACTICE RENEWAL'],
                icon: Icons.image_outlined,
              ),
            ),

            const SizedBox(height: 32),

            // Qualification Section
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: Text(
                'Qualification',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: RevivalColors.deepNavy,
                ),
              ),
            ),
            const SizedBox(height: 16),
             FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: const _DocumentCard(
                title: 'MBBS/MD Degree Copy',
                date: '29/12/2024',
                isVerified: true,
                usedFor: ['MED RENEWAL', 'SPECIALITY RENEWAL'],
                icon: Icons.school_outlined,
              ),
            ),
             const SizedBox(height: 16),
             FadeInUp(
              delay: const Duration(milliseconds: 700),
              child: const _DocumentCard(
                title: 'Medical Council Registration',
                date: '15/01/2025',
                isVerified: false,
                usedFor: ['MED RENEWAL'],
                icon: Icons.verified_outlined,
              ),
            ),
            
            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: RevivalColors.navyBlue,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Add Document',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _DocumentCard extends StatelessWidget {
  final String title;
  final String date;
  final bool isVerified;
  final List<String> usedFor;
  final IconData icon;

  const _DocumentCard({
    required this.title,
    required this.date,
    required this.isVerified,
    required this.usedFor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: RevivalColors.softGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: RevivalColors.navyBlue),
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
                        fontWeight: FontWeight.bold,
                        color: RevivalColors.deepNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (isVerified) ...[
                          const Icon(Icons.check_circle, size: 16, color: RevivalColors.success),
                          const SizedBox(width: 4),
                          Text(
                            'VERIFIED',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: RevivalColors.success,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(width: 4, height: 4, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          date,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: RevivalColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.remove_red_eye_outlined, color: RevivalColors.deepNavy),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 1, height: 1),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Used for: ',
                style: GoogleFonts.outfit(
                  fontSize: 11,
                  color: RevivalColors.darkGrey,
                ),
              ),
              Expanded(
                child: Text(
                  usedFor.join('   '),
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.navyBlue,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
