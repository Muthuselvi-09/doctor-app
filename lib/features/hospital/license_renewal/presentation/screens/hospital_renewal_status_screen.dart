import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/hospital/license_renewal/data/hospital_license_dummy_data.dart';
import 'package:flutter/material.dart';

class HospitalRenewalStatusScreen extends StatelessWidget {
  const HospitalRenewalStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: RevivalColors.softGrey,
        appBar: AppBar(
          title: const Text("Renewal Status"),
          backgroundColor: RevivalColors.navyBlue,
          iconTheme: const IconThemeData(color: RevivalColors.white),
          titleTextStyle: const TextStyle(color: RevivalColors.white, fontSize: 18),
          bottom: const TabBar(
            labelColor: RevivalColors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: RevivalColors.activeGreen,
            tabs: [
              Tab(text: "Active"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStatusList(isActive: true),
            _buildStatusList(isActive: false),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusList({required bool isActive}) {
    // Dummy Data for Status
    final activeItems = [
      {
        "name": "Hospital Registration Renewal",
        "status": "In Progress",
        "date": "Sub: 04 Feb 2026",
        "color": RevivalColors.warning,
      },
      {
        "name": "Fire & Safety License Renewal",
        "status": "Documents Verified",
        "date": "Sub: 01 Feb 2026",
        "color": RevivalColors.primaryBlue,
      },
    ];

    final historyItems = [
      {
        "name": "Trade License Renewal",
        "status": "Certificate Issued",
        "date": "Issued: 12 Jan 2025",
        "color": RevivalColors.success,
      },
    ];

    final items = isActive ? activeItems : historyItems;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildStatusCard(item);
      },
    );
  }

  Widget _buildStatusCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item["name"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: RevivalColors.navyBlue,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (item["color"] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: item["color"]),
                  ),
                  child: Text(
                    item["status"],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: item["color"],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: RevivalColors.darkGrey),
                const SizedBox(width: 6),
                Text(
                  item["date"],
                  style: const TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                ),
                const Spacer(),
                const Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: RevivalColors.primaryBlue,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 10, color: RevivalColors.primaryBlue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
