import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/revival_colors.dart';

class MasterProfileScreen extends StatefulWidget {
  const MasterProfileScreen({super.key});

  @override
  State<MasterProfileScreen> createState() => _MasterProfileScreenState();
}

class _MasterProfileScreenState extends State<MasterProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.white,
      appBar: AppBar(
        title: const Text('Master Profile'),
        backgroundColor: RevivalColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
        ),
        titleTextStyle: const TextStyle(
          color: RevivalColors.navyBlue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoBox(),
            const SizedBox(height: 32),
            _buildTextField('Full Name', 'e.g. Dr. Rajesh Kumar'),
            _buildTextField('Medical Council Name', 'e.g. Karnataka Medical Council'),
            _buildTextField('Registration Number', 'e.g. KMC-12345'),
            _buildTextField('Year of Registration', 'e.g. 2015'),
            _buildTextField('Specialization', 'e.g. Cardiologist'),
            _buildTextField('Mobile Number', '+91 98XXX XXXXX'),
            _buildTextField('Email', 'rajesh.k@example.com'),
            _buildTextField('Address', 'Full clinic or residential address', maxLines: 3),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.push('/revival-document-upload'),
              style: ElevatedButton.styleFrom(
                backgroundColor: RevivalColors.navyBlue,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Save & Continue',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: RevivalColors.accent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: RevivalColors.navyBlue.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: RevivalColors.navyBlue),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'These details are collected once and reused for all future renewals.',
              style: TextStyle(
                fontSize: 13,
                color: RevivalColors.navyBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: RevivalColors.navyBlue,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: RevivalColors.darkGrey, fontSize: 14),
              filled: true,
              fillColor: RevivalColors.softGrey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
