import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/theme/revival_colors.dart';
import '../../../../../hospital/license_renewal/presentation/widgets/hospital_upload_card.dart'; // Reuse Hospital widget or create similar
import '../../../../../pharmacy/license_renewal/domain/models/pharmacy_license_config.dart';

class Step3PharmacyDocuments extends StatelessWidget {
  final PharmacyLicenseConfig licenseConfig;

  const Step3PharmacyDocuments({super.key, required this.licenseConfig});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED), // Orange 50
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.orange),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Ensure all documents are clear, signed, and in PDF/JPG format. Max size 5MB.",
                    style: GoogleFonts.outfit(color: Colors.brown, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            "Required Documents for ${licenseConfig.name}",
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue),
          ),
          const SizedBox(height: 16),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: licenseConfig.requiredDocuments.length,
            itemBuilder: (context, index) {
              final docName = licenseConfig.requiredDocuments[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                // Reusing HospitalUploadCard as it is generic enough
                child: HospitalUploadCard(
                  documentName: docName,
                  description: "Upload valid $docName",
                  onUpload: () {
                    // Navigate to real upload screen safely
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.push('/revival-upload-update', extra: {
                        'title': docName,
                        'id': docName,
                      });
                    });
                  },
                ),
              );
            },
          ),
           const SizedBox(height: 40),
        ],
      ),
    );
  }
}
