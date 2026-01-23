import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Ultra soft blue-grey background
      appBar: AppBar(
        title: const Text('Doctor Portal', style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF64748B)),
            onPressed: () {}, 
          ),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Color(0xFF64748B)),
            onPressed: () => context.push('/document-list'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Medical Credentials'),
            const SizedBox(height: 12),
            _buildGridSection(context, [
              {'name': 'Medical License', 'icon': Icons.badge_outlined, 'status': 'Active', 'expiry': 'Oct 2026', 'docs': '4'},
              {'name': 'Speciality License', 'icon': Icons.workspace_premium_outlined, 'status': 'Active', 'expiry': 'Nov 2027', 'docs': '3'},
              {'name': 'CME Credits', 'icon': Icons.school_outlined, 'status': 'Pending', 'expiry': 'Dec 2025', 'docs': '1'},
              {'name': 'Medical Indemnity', 'icon': Icons.shield_outlined, 'status': 'Expiring Soon', 'expiry': 'Aug 2025', 'docs': '2'},
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('Establishment Licenses'),
            const SizedBox(height: 12),
             _buildGridSection(context, [
              {'name': 'Practice License', 'icon': Icons.local_hospital_outlined, 'status': 'Active', 'expiry': 'Jun 2026', 'docs': '6'},
              {'name': 'Clinic License', 'icon': Icons.storefront_outlined, 'status': 'Pending', 'expiry': 'Jan 2025', 'docs': '2'},
              {'name': 'Hospital License', 'icon': Icons.apartment_outlined, 'status': 'Active', 'expiry': 'Aug 2026', 'docs': '8'},
              {'name': 'E-Prescription', 'icon': Icons.medication_outlined, 'status': 'Active', 'expiry': 'Mar 2027', 'docs': '5'},
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Color(0xFF475569), // Slate 600
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildGridSection(BuildContext context, List<Map<String, dynamic>> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3, // Compact cards
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: _buildCompactCard(context, item),
        );
      },
    );
  }

  Widget _buildCompactCard(BuildContext context, Map<String, dynamic> item) {
    String status = item['status']! as String;
    Color statusColor = const Color(0xFF10B981); // Emerald 500
    Color bgGradientStart = Colors.white;
    Color bgGradientEnd = const Color(0xFFF1F5F9); // Slate 100

    if (status == 'Expiring Soon') {
      statusColor = const Color(0xFFF59E0B); // Amber 500
      bgGradientStart = const Color(0xFFFFFBEB); // Amber 50
    } else if (status == 'Pending') {
      statusColor = const Color(0xFFEF4444); // Red 500
      bgGradientStart = const Color(0xFFFEF2F2); // Red 50
    }

    return InkWell(
      onTap: () {
         context.push('/compliance-detail', extra: item['name']);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)), // Slate 200
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgGradientStart, bgGradientEnd],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF64748B).withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                       BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  ),
                  child: Icon(item['icon'] as IconData, size: 18, color: const Color(0xFF334155)),
                ),
                 Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name']! as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 2),
                Text(
                   status,
                   style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  item['expiry']! as String,
                   style: const TextStyle(fontSize: 10, color: Color(0xFF64748B)),
                ),
                Row(
                  children: [
                     const Icon(Icons.attachment_rounded, size: 10, color: Color(0xFF94A3B8)),
                     const SizedBox(width: 2),
                     Text(
                      item['docs']! as String,
                       style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
