import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ComplianceSafetyScreen extends StatefulWidget {
  const ComplianceSafetyScreen({super.key});

  @override
  State<ComplianceSafetyScreen> createState() => _ComplianceSafetyScreenState();
}

class _ComplianceSafetyScreenState extends State<ComplianceSafetyScreen> {
  final List<Map<String, dynamic>> _safetyChecks = [
    {'title': 'Biomedical Waste Disposal', 'status': 'Compliant', 'icon': Icons.delete_sweep_rounded, 'color': Colors.green},
    {'title': 'Fire Safety Certificate', 'status': 'Pending Review', 'icon': Icons.fire_extinguisher_rounded, 'color': Colors.orange},
    {'title': 'Pollution NOC', 'status': 'Not Required', 'icon': Icons.eco_rounded, 'color': Colors.grey},
    {'title': 'Equipment Calibration', 'status': 'Compliant', 'icon': Icons.settings_suggest_rounded, 'color': Colors.green},
    {'title': 'Staff Health Records', 'status': 'Awaiting Upload', 'icon': Icons.people_outline_rounded, 'color': Colors.blue},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Compliance & Safety'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildComplianceHeader(),
            const SizedBox(height: 32),
            _buildSectionTitle('Active Certifications'),
            const SizedBox(height: 16),
            _buildSafetyGrid(),
            const SizedBox(height: 32),
            _buildSectionTitle('Safety Checklists'),
            const SizedBox(height: 16),
            _buildChecklist(),
            const SizedBox(height: 48),
            _buildNextButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFFE8F5E9),
              child: Icon(Icons.verified_user_rounded, color: Colors.green, size: 36),
            ),
            SizedBox(height: 16),
            Text(
              'Compliance Readiness',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              '85% Standards Met',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return FadeInLeft(
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSafetyGrid() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _safetyChecks.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final check = _safetyChecks[index];
        return FadeInRight(
          delay: Duration(milliseconds: 100 * index),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: (check['color'] as Color).withOpacity(0.1), shape: BoxShape.circle),
                  child: Icon(check['icon'] as IconData, color: check['color'] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(check['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(check['status'] as String, style: TextStyle(color: check['color'] as Color, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChecklist() {
    final list = [
      'Emergency exits marked and clear',
      'Bio-waste bins correctly segregated',
      'Lead gowns/protection available (if X-ray)',
      'Staff trained in fire protocols',
      'Medical gas storage secured',
    ];

    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Column(
          children: list.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                const Icon(Icons.check_box_rounded, color: AppColors.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(item, style: const TextStyle(fontSize: 13))),
              ],
            ),
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () => context.push('/practice-summary'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        shadowColor: AppColors.primary.withOpacity(0.4),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Review Application', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}
