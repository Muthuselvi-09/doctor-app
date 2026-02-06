import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/revival_colors.dart';

class PharmacyStatusScreen extends StatefulWidget {
  const PharmacyStatusScreen({super.key});

  @override
  State<PharmacyStatusScreen> createState() => _PharmacyStatusScreenState();
}

class _PharmacyStatusScreenState extends State<PharmacyStatusScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text("Application Status", style: GoogleFonts.outfit(color: RevivalColors.white, fontWeight: FontWeight.bold)),
        backgroundColor: RevivalColors.navyBlue,
        iconTheme: const IconThemeData(color: RevivalColors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: RevivalColors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.white,
          labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: "Active Applications"),
            Tab(text: "Renewal History"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildActiveList(),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildActiveList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatusCard(
          "Drug License Renewal",
          "Submitted on 12 Oct 2025",
          "Under Verification",
          0.6,
          Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildStatusCard(
          "Bio-Medical Waste Renewal",
          "Submitted on 10 Oct 2025",
          "Document Review",
          0.3,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildStatusCard(
          "Pharmacy Registration",
          "Renewed on Jan 2024",
          "Completed",
          1.0,
          RevivalColors.success,
          isHistory: true,
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, String subtitle, String status, double progress, Color color, {bool isHistory = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RevivalColors.midGrey.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16, color: RevivalColors.deepNavy)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: GoogleFonts.outfit(color: RevivalColors.darkGrey, fontSize: 12)),
          const SizedBox(height: 16),
          if (!isHistory)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: RevivalColors.softGrey,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 6,
              ),
            ),
          if (isHistory)
            OutlinedButton.icon(
              onPressed: null, // Placeholder
              icon: const Icon(Icons.download, size: 16),
              label: const Text("Download Certificate"),
            ),
        ],
      ),
    );
  }
}
