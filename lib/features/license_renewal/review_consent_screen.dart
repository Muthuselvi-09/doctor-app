import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class ReviewConsentScreen extends StatefulWidget {
  const ReviewConsentScreen({super.key});

  @override
  State<ReviewConsentScreen> createState() => _ReviewConsentScreenState();
}

class _ReviewConsentScreenState extends State<ReviewConsentScreen> {
  bool _isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Review & Consent'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Document Summary'),
            _buildSummaryCard(),
            const SizedBox(height: 32),
            _buildConfirmationSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
      ),
    );
  }

  Widget _buildSummaryCard() {
    final docs = [
      {'name': 'MBBS/MD Degree Copy', 'status': 'From Vault'},
      {'name': 'Government ID Proof', 'status': 'From Vault'},
      {'name': 'Medical Council Reg.', 'status': 'From Vault'},
      {'name': 'Practice Proof', 'status': 'Newly Uploaded'},
      {'name': 'Old License Copy', 'status': 'Updated'},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.softGrey,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: docs.map((doc) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              const Icon(Icons.description_outlined, size: 18, color: RevivalColors.navyBlue),
              const SizedBox(width: 12),
              Expanded(
                child: Text(doc['name']!, style: const TextStyle(fontSize: 14, color: RevivalColors.navyBlue, fontWeight: FontWeight.w500)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: RevivalColors.white, borderRadius: BorderRadius.circular(8)),
                child: Text(doc['status']!, style: const TextStyle(fontSize: 10, color: RevivalColors.darkGrey, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildConfirmationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.navyBlue.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          const Icon(Icons.assignment_turned_in_rounded, color: RevivalColors.navyBlue, size: 40),
          const SizedBox(height: 20),
          const Text(
            'Important Confirmation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 12),
          const Text(
            '“Our team will apply and complete your license renewal on your behalf”',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: RevivalColors.primaryBlue,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(
                value: _isConfirmed,
                activeColor: RevivalColors.navyBlue,
                onChanged: (val) => setState(() => _isConfirmed = val ?? false),
              ),
              const Expanded(
                child: Text(
                  'I authorize DoctorRevival to handle my license renewal process.',
                  style: TextStyle(fontSize: 13, color: RevivalColors.darkGrey),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: FadeInUp(
        child: ElevatedButton(
          onPressed: _isConfirmed ? () => context.push('/revival-tracking-visual') : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            disabledBackgroundColor: RevivalColors.darkGrey.withOpacity(0.3),
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Confirm & Proceed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}
