import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/hospital/license_renewal/domain/models/hospital_license_config.dart';
import 'package:flutter/material.dart';

class Step5ReviewConfirm extends StatelessWidget {
  final HospitalLicenseConfig licenseConfig;
  final VoidCallback onEditProvider;
  final VoidCallback onEditLicense;
  final VoidCallback onEditDocs;

  const Step5ReviewConfirm({
    super.key,
    required this.licenseConfig,
    required this.onEditProvider,
    required this.onEditLicense,
    required this.onEditDocs,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Review Application"),
          const SizedBox(height: 8),
          const Text(
            "Please review all details before submitting to the Revival team.",
            style: TextStyle(color: RevivalColors.darkGrey),
          ),
          
          const SizedBox(height: 24),
          _buildSummaryCard(
            title: "Provider Details",
            icon: Icons.local_hospital,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Apollo Speciality Hospital", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Reg No: TN-HOSP-2023-8899"),
                Text("Chennai, 600006"),
              ],
            ),
            onEdit: onEditProvider,
          ),

          const SizedBox(height: 16),
          _buildSummaryCard(
            title: "License Details",
            icon: licenseConfig.icon,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(licenseConfig.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text("Issued By: Directorate of Medical Services"),
                const Text("Expiry: 31/12/2026"),
                const Text("Cycle: Annual"),
              ],
            ),
            onEdit: onEditLicense,
          ),

          const SizedBox(height: 16),
          _buildSummaryCard(
            title: "Uploaded Documents",
            icon: Icons.folder,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${licenseConfig.requiredDocuments.length} Documents Attached", style: const TextStyle(fontWeight: FontWeight.bold, color: RevivalColors.success)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: licenseConfig.requiredDocuments.take(3).map((doc) {
                    return Chip(
                      label: Text(doc, style: const TextStyle(fontSize: 10)),
                      backgroundColor: RevivalColors.softGrey,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
                if (licenseConfig.requiredDocuments.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text("+ ${licenseConfig.requiredDocuments.length - 3} more", style: const TextStyle(fontSize: 12, color: RevivalColors.primaryBlue)),
                  ),
              ],
            ),
            onEdit: onEditDocs,
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(value: true, onChanged: (val) {}, activeColor: RevivalColors.primaryBlue),
              const Expanded(
                child: Text(
                  "I hereby declare that the details furnished above are true and correct to the best of my knowledge.",
                  style: TextStyle(fontSize: 12, color: RevivalColors.darkGrey),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: RevivalColors.navyBlue,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 3,
          color: RevivalColors.primaryBlue,
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required IconData icon,
    required Widget content,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: RevivalColors.primaryBlue, size: 20),
                  const SizedBox(width: 8),
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 18, color: RevivalColors.darkGrey),
                onPressed: onEdit,
                splashRadius: 20,
              )
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),
          DefaultTextStyle(
            style: const TextStyle(color: RevivalColors.darkGrey, fontSize: 13, height: 1.4),
            child: content,
          ),
        ],
      ),
    );
  }
}
