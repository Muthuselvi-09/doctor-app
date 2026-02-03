import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class RenewalHistoryScreen extends StatelessWidget {
  const RenewalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: const Text('Renewal History'),
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
            const Text(
              'Past Records',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
            ),
            const SizedBox(height: 16),
            _buildHistoryItem(
              year: '2021',
              period: '24 Oct 2021 - 24 Oct 2026',
              status: 'Renewed',
              isCurrent: true,
            ),
            _buildHistoryItem(
              year: '2016',
              period: '24 Aug 2016 - 24 Aug 2021',
              status: 'Completed',
            ),
            _buildHistoryItem(
              year: '2011',
              period: '10 Aug 2011 - 10 Aug 2016',
              status: 'Completed',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String year,
    required String period,
    required String status,
    bool isCurrent = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RevivalColors.white,
        borderRadius: BorderRadius.circular(24),
        border: isCurrent ? Border.all(color: RevivalColors.activeGreen.withOpacity(0.3), width: 1.5) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Renewal cycle $year',
                style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.navyBlue, fontSize: 15),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isCurrent ? RevivalColors.activeGreen : RevivalColors.darkGrey).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isCurrent ? RevivalColors.activeGreen : RevivalColors.darkGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.date_range_rounded, size: 14, color: RevivalColors.darkGrey),
              const SizedBox(width: 8),
              Text(period, style: const TextStyle(fontSize: 13, color: RevivalColors.darkGrey)),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(height: 1)),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download_rounded, size: 18),
                  label: const Text('Certificate'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: RevivalColors.navyBlue,
                    side: const BorderSide(color: RevivalColors.navyBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: const Text('Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: RevivalColors.softGrey,
                    foregroundColor: RevivalColors.navyBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
