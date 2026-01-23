import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';

class EPrescriptionEditor extends StatefulWidget {
  const EPrescriptionEditor({super.key});

  @override
  State<EPrescriptionEditor> createState() => _EPrescriptionEditorState();
}

class _EPrescriptionEditorState extends State<EPrescriptionEditor> {
  final List<Map<String, String>> _medicines = [
    {'name': 'Amoxicillin 500mg', 'dose': '1-0-1', 'duration': '5 Days'},
    {'name': 'Paracetamol 650mg', 'dose': '0-0-1', 'duration': '3 Days'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Digital Prescription'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.print_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientHeader(),
            const SizedBox(height: 32),
            _buildSectionTitle('Diagnosis / Findings'),
            const SizedBox(height: 12),
            _buildDiagnosisInput(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle('Medications'),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add Medicine'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._medicines.map((med) => _buildMedicineItem(med)),
            const SizedBox(height: 32),
            _buildSectionTitle('Advice / Follow-up'),
            const SizedBox(height: 12),
            _buildDiagnosisInput(hint: 'Enter dietary advice or follow-up date'),
            const SizedBox(height: 48),
            FadeInUp(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.send_rounded),
                    SizedBox(width: 12),
                    Text('Send to Patient'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.accent,
              child: Icon(Icons.person, color: AppColors.primary),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Jane Cooper', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Female, 28y • ID: #P-8821', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.history_rounded, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildDiagnosisInput({String hint = 'Enter clinical diagnosis...'}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: TextField(
        maxLines: 2,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildMedicineItem(Map<String, String> med) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.medication_outlined, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(med['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('${med['dose']} • ${med['duration']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
