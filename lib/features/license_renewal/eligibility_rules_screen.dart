import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class EligibilityRulesScreen extends StatelessWidget {
  const EligibilityRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Eligibility & Rules'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: RevivalColors.navyBlue, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBanner(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Renewal Conditions'),
                  _buildConditionItem('Mandatory CME Credits', 'Minimum 30 credit hours required for the current 5-year cycle.'),
                  _buildConditionItem('Clearance Certificate', 'No pending enquiries or disciplinary actions from the council.'),
                  _buildConditionItem('Resident Proof', 'Updated address proof if there is a change in practice location.'),
                  const SizedBox(height: 32),
                  _buildSectionTitle('CME Credit Requirements'),
                  _buildCMEDetailBox(),
                  const SizedBox(height: 32),
                  _buildSectionTitle('State Specific Rules'),
                  _buildRuleItem('Electronic submission is mandatory for all specialists.'),
                  _buildRuleItem('Original documents must be produced only if requested by the administrator.'),
                  _buildRuleItem('Renewal fee must be paid during the final review step.'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(context),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      color: RevivalColors.softGrey,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: RevivalColors.white, shape: BoxShape.circle),
            child: const Icon(Icons.gavel_rounded, color: RevivalColors.navyBlue, size: 20),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Please review the eligibility criteria carefully before proceeding.',
              style: TextStyle(fontSize: 13, color: RevivalColors.navyBlue, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
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

  Widget _buildConditionItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: FadeInLeft(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline_rounded, color: RevivalColors.activeGreen, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
                  const SizedBox(height: 2),
                  Text(description, style: const TextStyle(fontSize: 13, color: RevivalColors.darkGrey, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCMEDetailBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.navyBlue.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildCMERow('Required', '30.0'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          _buildCMERow('Your Progress', '18.5', valueColor: RevivalColors.primaryBlue),
          const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Divider(height: 1)),
          _buildCMERow('Status', 'Eligible', valueColor: RevivalColors.activeGreen),
        ],
      ),
    );
  }

  Widget _buildCMERow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: RevivalColors.darkGrey)),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: valueColor ?? RevivalColors.navyBlue)),
      ],
    );
  }

  Widget _buildRuleItem(String rule) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: CircleAvatar(radius: 3, backgroundColor: RevivalColors.primaryBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(rule, style: const TextStyle(fontSize: 14, color: RevivalColors.darkGrey)),
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
      child: ElevatedButton(
        onPressed: () => context.push('/revival-document-checklist'),
        style: ElevatedButton.styleFrom(
          backgroundColor: RevivalColors.navyBlue,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text('I Understand & Agree', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
