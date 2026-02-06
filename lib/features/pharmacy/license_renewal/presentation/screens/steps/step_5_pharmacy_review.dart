import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/theme/revival_colors.dart';
import 'package:doctor_app/features/pharmacy/license_renewal/domain/models/pharmacy_license_config.dart';

class Step5PharmacyReview extends StatelessWidget {
  final PharmacyLicenseConfig? licenseConfig; // Optional for placeholder compatibility
  final VoidCallback? onEditProvider;
  final VoidCallback? onEditLicense;
  final VoidCallback? onEditDocs;

  const Step5PharmacyReview({
    super.key, 
    this.licenseConfig,
    this.onEditProvider,
    this.onEditLicense,
    this.onEditDocs,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Review Your Application", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
          const SizedBox(height: 6),
          Text("Please verify all details before submitting.", style: GoogleFonts.outfit(color: RevivalColors.darkGrey)),
          const SizedBox(height: 24),
          
          _buildSummaryCard(
            "Provider Details",
            [
              _buildRow("Pharmacy Name", "Green Cross Pharmacy"),
              _buildRow("Type", "Retail"),
              _buildRow("Mobile", "+91 98765 43210"),
            ],
            onEditProvider,
          ),
          const SizedBox(height: 16),
          
          _buildSummaryCard(
            "License Details",
            [
              _buildRow("License Type", licenseConfig?.name ?? "Drug License"),
              _buildRow("License No", "DR-PH-88229"),
              _buildRow("Expiry", "12 Oct 2026"),
            ],
            onEditLicense,
          ),
          const SizedBox(height: 16),
          
           _buildSummaryCard(
            "Documents",
            [
              _buildRow("Total Required", "${licenseConfig?.requiredDocuments.length ?? 5} Documents"),
              _buildRow("Status", "All Uploaded", isSuccess: true),
            ],
            onEditDocs,
          ),
           const SizedBox(height: 16),
           
           Row(
             children: [
               Checkbox(value: true, onChanged: (v){}, activeColor: RevivalColors.navyBlue),
               Expanded(
                 child: Text(
                   "I hereby declare that the information provided is true and correct.",
                   style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.darkGrey),
                 ),
               ),
             ],
           ),
           
           const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, List<Widget> children, VoidCallback? onEdit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: RevivalColors.midGrey.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16, color: RevivalColors.deepNavy)),
              if (onEdit != null)
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 14),
                  label: const Text("Edit"),
                  style: TextButton.styleFrom(foregroundColor: RevivalColors.primaryBlue, padding: EdgeInsets.zero),
                ),
            ],
          ),
          const Divider(),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildRow(String label, String value, {bool isSuccess = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.outfit(color: RevivalColors.darkGrey, fontSize: 14)),
          Text(
            value, 
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w600, 
              color: isSuccess ? RevivalColors.success : RevivalColors.deepNavy,
            ),
          ),
        ],
      ),
    );
  }
}
