import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/theme/app_colors.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({super.key});

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  final List<Map<String, String>> _documents = [
    {'title': 'Medical License Front', 'type': 'PDF', 'size': '2.1 MB', 'date': 'Oct 24, 2026', 'status': 'Active'},
    {'title': 'Medical License Back', 'type': 'PDF', 'size': '1.8 MB', 'date': 'Oct 24, 2026', 'status': 'Active'},
    {'title': 'Indemnity Insurance Policy', 'type': 'PDF', 'size': '3.2 MB', 'date': 'Oct 12, 2026', 'status': 'Expiring'},
    {'title': 'Clinic Registration Deed', 'type': 'JPG', 'size': '4.5 MB', 'date': 'Jan 15, 2025', 'status': 'Pending'},
    {'title': 'Aadhaar Card', 'type': 'JPG', 'size': '1.1 MB', 'date': 'Lifetime', 'status': 'Active'},
    {'title': 'CME Certificate 2024', 'type': 'PDF', 'size': '520 KB', 'date': 'Dec 31, 2029', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('All Documents', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(color: AppColors.textPrimary),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded, color: AppColors.textPrimary),
            onPressed: () {}, // TODO: Implement sorting
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _documents.length,
        separatorBuilder: (c, i) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final doc = _documents[index];
          return FadeInUp(
            delay: Duration(milliseconds: 50 * index),
            child: _buildDocumentCard(doc),
          );
        },
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, String> doc) {
    Color statusColor = Colors.green;
    if (doc['status'] == 'Expiring') statusColor = Colors.orange;
    if (doc['status'] == 'Pending') statusColor = Colors.redAccent;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              doc['type'] == 'PDF' ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  '${doc['size']} • Expires: ${doc['date']}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              doc['status']!,
              style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
