import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

enum RenewalStep {
  request,
  track,
  chatbot,
  documents,
  completed,
  invoice,
}

class RenewalTrackingTimeline extends StatelessWidget {
  final RenewalStep currentStep;

  const RenewalTrackingTimeline({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'title': 'Request', 'icon': Icons.edit_document, 'step': RenewalStep.request},
      {'title': 'Track', 'icon': Icons.track_changes, 'step': RenewalStep.track},
      {'title': 'Chatbot', 'icon': Icons.smart_toy, 'step': RenewalStep.chatbot},
      {'title': 'Docs', 'icon': Icons.upload_file, 'step': RenewalStep.documents},
      {'title': 'Done', 'icon': Icons.check_circle, 'step': RenewalStep.completed},
      {'title': 'Invoice', 'icon': Icons.receipt, 'step': RenewalStep.invoice},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: steps.map((stepMap) {
          final index = steps.indexOf(stepMap);
          final step = stepMap['step'] as RenewalStep;
          final isCompleted = step.index <= currentStep.index;
          final isCurrent = step == currentStep;
          
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isCompleted ? RevivalColors.navyBlue : RevivalColors.softGrey,
                    shape: BoxShape.circle,
                    border: isCurrent ? Border.all(color: RevivalColors.accent, width: 2) : null,
                  ),
                  child: Icon(
                    stepMap['icon'] as IconData,
                    size: 16,
                    color: isCompleted ? Colors.white : RevivalColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stepMap['title'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? RevivalColors.deepNavy : RevivalColors.darkGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
