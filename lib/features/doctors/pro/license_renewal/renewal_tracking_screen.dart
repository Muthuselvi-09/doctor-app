import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/revival_colors.dart';

class RenewalTrackingScreen extends StatelessWidget {
  const RenewalTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: RevivalColors.softGrey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.deepNavy),
            onPressed: () => context.pop(),
          ),
          title: Text('License Lifecycle', style: GoogleFonts.outfit(color: RevivalColors.deepNavy, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: RevivalColors.navyBlue,
            unselectedLabelColor: RevivalColors.darkGrey,
            indicatorColor: RevivalColors.navyBlue,
            labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Active Log'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildActiveLog(context),
            _buildHistoryList(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: RevivalColors.activeGreen,
          icon: const Icon(Icons.smart_toy),
          label: Text('Ask Chatbot', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildActiveLog(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCurrentStatusCard(context),
          const SizedBox(height: 32),
          Text('Compliance Timeline', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy)),
          const SizedBox(height: 24),
          _buildVerticalTimeline(),
          const SizedBox(height: 80), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    final history = [
      {'year': '2024', 'status': 'Approved', 'date': 'Oct 24, 2024', 'cert': 'LIC-2024.pdf'},
      {'year': '2019', 'status': 'Approved', 'date': 'Oct 22, 2019', 'cert': 'LIC-2019.pdf'},
      {'year': '2014', 'status': 'Approved', 'date': 'Oct 20, 2014', 'cert': 'LIC-2014.pdf'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final item = history[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: RevivalColors.softGrey, shape: BoxShape.circle),
                child: const Icon(Icons.history, color: RevivalColors.navyBlue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Renewal ${item['year']}', style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16, color: RevivalColors.deepNavy)),
                    Text('Completed on ${item['date']}', style: GoogleFonts.outfit(color: RevivalColors.darkGrey, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('Approved', style: GoogleFonts.outfit(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrentStatusCard(BuildContext context) {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: RevivalColors.midGrey),
           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: RevivalColors.softGrey,
              child: Icon(Icons.hourglass_bottom_rounded, color: RevivalColors.navyBlue, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              'Application Pending',
              style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy),
            ),
            const SizedBox(height: 8),
            Text(
              'Your renewal is being reviewed by the Medical Council. Check back in 2-3 business days.',
              style: GoogleFonts.outfit(color: RevivalColors.darkGrey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalTimeline() {
    final events = [
      {'title': 'License Issued', 'date': 'Oct 24, 2021', 'status': 'completed', 'desc': 'Initial registration approved.'},
      {'title': 'Verified for Renewal', 'date': 'Jan 15, 2026', 'status': 'completed', 'desc': 'Documents verified.'},
      {'title': 'Renewal Submitted', 'date': 'Jan 22, 2026', 'status': 'active', 'desc': 'Application under review.'},
      {'title': 'Bot Verification', 'date': 'Jan 23, 2026', 'status': 'pending', 'desc': 'Chatbot pre-check pending.'},
      {'title': 'Council Approval', 'date': 'Feb 10, 2026', 'status': 'pending', 'desc': 'Final authority decision.'},
    ];

    return Column(
      children: List.generate(events.length, (index) {
        final event = events[index];
        return _buildTimelineStep(
          event['title']!,
          event['date']!,
          event['desc']!,
          event['status']!,
          isLast: index == events.length - 1,
        );
      }),
    );
  }

  Widget _buildTimelineStep(String title, String date, String desc, String status, {bool isLast = false}) {
    Color pointColor;
    Color lineColor;
    
    switch (status) {
      case 'completed':
        pointColor = Colors.green;
        lineColor = Colors.green;
        break;
      case 'active':
        pointColor = RevivalColors.navyBlue;
        lineColor = RevivalColors.navyBlue;
        break;
      default:
        pointColor = RevivalColors.midGrey;
        lineColor = RevivalColors.midGrey;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16, height: 16,
              decoration: BoxDecoration(color: pointColor, shape: BoxShape.circle),
              child: status == 'completed' ? const Icon(Icons.check, size: 10, color: Colors.white) : null,
            ),
            if (!isLast) Container(width: 2, height: 60, color: lineColor.withOpacity(0.3)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 15, color: RevivalColors.deepNavy)),
                   Text(date, style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.darkGrey)),
                ],
              ),
               const SizedBox(height: 4),
               Text(desc, style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.darkGrey)),
               const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}

