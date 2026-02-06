import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/hospital/license_renewal/domain/models/hospital_license_config.dart';
import 'package:flutter/material.dart';
import '../../widgets/hospital_upload_card.dart';

class Step3DocumentsUpload extends StatelessWidget {
  final HospitalLicenseConfig licenseConfig;

  const Step3DocumentsUpload({super.key, required this.licenseConfig});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Required Documents"),
          const SizedBox(height: 8),
          Text(
            "Please upload the following documents for ${licenseConfig.name}.",
            style: const TextStyle(color: RevivalColors.darkGrey),
          ),
          const SizedBox(height: 20),

          // Dynamic List of Documents
          ...licenseConfig.requiredDocuments.map((docName) {
            return HospitalUploadCard(
              documentName: docName,
              description: "Upload clear scanned copy (PDF/JPG)",
            );
          }),

          const SizedBox(height: 16),
          // Additional Info Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: RevivalColors.accent.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: RevivalColors.midGrey),
            ),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: RevivalColors.primaryBlue, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Ensure all documents are valid and clearly visible to avoid rejection.",
                    style: TextStyle(fontSize: 12, color: RevivalColors.primaryBlue),
                  ),
                ),
              ],
            ),
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
}
