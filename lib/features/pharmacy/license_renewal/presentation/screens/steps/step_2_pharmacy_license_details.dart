import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';
import '../../../../../pharmacy/license_renewal/domain/models/pharmacy_license_config.dart';

class Step2PharmacyLicenseDetails extends StatefulWidget {
  final PharmacyLicenseConfig licenseConfig;

  const Step2PharmacyLicenseDetails({super.key, required this.licenseConfig});

  @override
  State<Step2PharmacyLicenseDetails> createState() => _Step2PharmacyLicenseDetailsState();
}

class _Step2PharmacyLicenseDetailsState extends State<Step2PharmacyLicenseDetails> {
  final _licenseNumController = TextEditingController();
  final _issuingAuthController = TextEditingController();
  final _remarksController = TextEditingController();
  
  DateTime? _issueDate;
  DateTime? _expiryDate;
  String _status = "Active";

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
              color: RevivalColors.softGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: RevivalColors.primaryBlue.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(widget.licenseConfig.icon, color: RevivalColors.navyBlue, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Renewing License",
                        style: GoogleFonts.outfit(fontSize: 12, color: RevivalColors.darkGrey),
                      ),
                      Text(
                        widget.licenseConfig.name,
                        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text("Official License Details", style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.navyBlue)),
          const SizedBox(height: 16),
          
          _buildTextField("License Number", _licenseNumController, Icons.confirmation_number),
          const SizedBox(height: 12),
          _buildTextField("Issuing Authority", _issuingAuthController, Icons.account_balance),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Expanded(child: _buildDatePicker("Issue Date", _issueDate, (d) => setState(() => _issueDate = d))),
              const SizedBox(width: 12),
              Expanded(child: _buildDatePicker("Expiry Date", _expiryDate, (d) => setState(() => _expiryDate = d))),
            ],
          ),
          const SizedBox(height: 12),
          
          _buildDropdown("License Status", ["Active", "Expired", "Suspended"], _status, (val) => setState(() => _status = val!)),
          const SizedBox(height: 12),
          
          _buildTextField("Remarks (Optional)", _remarksController, Icons.note, maxLines: 3),
          
           const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: RevivalColors.midGrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
  
  Widget _buildDatePicker(String label, DateTime? date, Function(DateTime) onSelect) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        if (picked != null) onSelect(picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: RevivalColors.midGrey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: RevivalColors.midGrey, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                date == null ? label : "${date.day}/${date.month}/${date.year}",
                style: TextStyle(color: date == null ? RevivalColors.darkGrey : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
