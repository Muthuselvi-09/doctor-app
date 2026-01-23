import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/theme/app_colors.dart';

class ComplianceCalendarScreen extends StatefulWidget {
  const ComplianceCalendarScreen({super.key});

  @override
  State<ComplianceCalendarScreen> createState() => _ComplianceCalendarScreenState();
}

class _ComplianceCalendarScreenState extends State<ComplianceCalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Compliance Calendar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: _buildCalendarView(),
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('Reminders & Deadlines'),
            const SizedBox(height: 16),
            _buildDeadlineList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'January 2026',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_left_rounded)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.chevron_right_rounded)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Mock Week Headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) => _buildDayHeader(day)).toList(),
          ),
          const SizedBox(height: 12),
          // Mock Days Grid
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildDayHeader(String day) {
    return SizedBox(
      width: 30,
      child: Text(
        day,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: List.generate(5, (weekIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (dayIndex) {
              int day = weekIndex * 7 + dayIndex - 2;
              bool isDeadline = [5, 12, 24].contains(day);
              bool isToday = day == 22;

              if (day <= 0 || day > 31) return const SizedBox(width: 30);

              return Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primary : (isDeadline ? Colors.red.withOpacity(0.1) : Colors.transparent),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isToday || isDeadline ? FontWeight.bold : FontWeight.normal,
                    color: isToday ? Colors.white : (isDeadline ? Colors.red : AppColors.textPrimary),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDeadlineList() {
    final deadlines = [
      {'title': 'Medical License Renewal Due', 'date': 'In 45 Days', 'color': Colors.red},
      {'title': 'CME Credit Submission', 'date': 'In 12 Days', 'color': Colors.orange},
      {'title': 'Indemnity Insurance Update', 'date': 'In 5 Days', 'color': Colors.blue},
    ];

    return Column(
      children: deadlines.map((d) => FadeInRight(
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 40,
                decoration: BoxDecoration(
                  color: d['color'] as Color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text(d['date'] as String, style: TextStyle(color: d['color'] as Color, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_outlined, size: 20),
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }
}
