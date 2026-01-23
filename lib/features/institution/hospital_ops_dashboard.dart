import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../core/theme/app_colors.dart';

class HospitalOpsDashboard extends StatelessWidget {
  const HospitalOpsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Hospital Operations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickStats(),
            const SizedBox(height: 32),
            _buildSectionTitle('Department Performance'),
            const SizedBox(height: 16),
            _buildDepartmentList(),
            const SizedBox(height: 32),
            _buildSectionTitle('Footfall Analytics'),
            const SizedBox(height: 16),
            _buildFootfallChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildOpsStatCard('Total IP/OP', '340', Icons.people_rounded, Colors.purple),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildOpsStatCard('Available Beds', '12', Icons.bed_rounded, Colors.orange),
        ),
      ],
    );
  }

  Widget _buildOpsStatCard(String label, String value, IconData icon, Color color) {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDepartmentList() {
    final depts = [
      {'name': 'Cardiology', 'doctors': '12', 'load': 0.8},
      {'name': 'Orthopedics', 'doctors': '08', 'load': 0.6},
      {'name': 'Pediatrics', 'doctors': '15', 'load': 0.4},
    ];

    return Column(
      children: depts.map((dept) => _buildDeptItem(dept)).toList(),
    );
  }

  Widget _buildDeptItem(Map<String, dynamic> dept) {
    return FadeInLeft(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dept['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${dept['doctors']} Doctors ON-ROSTER', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Occupancy', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: dept['load'] as double,
                      backgroundColor: Colors.grey[200],
                      color: AppColors.primary,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFootfallChart() {
    return FadeInUp(
      child: Container(
        height: 190,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Peak Hour Analytics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Icon(Icons.insights_rounded, color: Colors.purple.withOpacity(0.5)),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(12, (index) {
                double height = [15, 30, 50, 70, 85, 100, 85, 70, 50, 30, 20, 10][index].toDouble();
                return Container(
                  height: height,
                  width: 10,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('8 AM', style: TextStyle(fontSize: 9, color: AppColors.textHint)),
                Text('2 PM', style: TextStyle(fontSize: 9, color: AppColors.textHint)),
                Text('8 PM', style: TextStyle(fontSize: 9, color: AppColors.textHint)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
