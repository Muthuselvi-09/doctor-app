import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TimelineWidget extends StatelessWidget {
  final List<TimelineItem> items;

  const TimelineWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: item.isDone ? Colors.green : Colors.grey[300],
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(color: (item.isDone ? Colors.green : Colors.grey).withOpacity(0.2), blurRadius: 6),
                          ],
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 30, // Adjust height as needed
                          color: item.isDone ? Colors.green.withOpacity(0.3) : Colors.grey[200],
                          margin: const EdgeInsets.symmetric(vertical: 4),
                        ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: item.isDone ? Colors.black87 : Colors.grey)),
                        Text(item.date, style: TextStyle(fontSize: 11, color: item.isDone ? AppColors.textSecondary : Colors.grey[400])),
                        const SizedBox(height: 16), // Spacing between items
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class TimelineItem {
  final String title;
  final String date;
  final bool isDone;

  TimelineItem({required this.title, required this.date, required this.isDone});
}
