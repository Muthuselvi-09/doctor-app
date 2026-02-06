import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/hospital/license_renewal/domain/models/hospital_license_config.dart';
import 'package:flutter/material.dart';

class Step2LicenseDetails extends StatefulWidget {
  final HospitalLicenseConfig licenseConfig;

  const Step2LicenseDetails({super.key, required this.licenseConfig});

  @override
  State<Step2LicenseDetails> createState() => _Step2LicenseDetailsState();
}

class _Step2LicenseDetailsState extends State<Step2LicenseDetails> {
  late TextEditingController _nameController;
  final _licenseNumberController = TextEditingController();
  final _issueDateController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _issuingAuthorityController = TextEditingController(text: "Directorate of Medical Services");
  final _remarksController = TextEditingController();

  String _renewalCycle = 'Annual';

  @override
  void initState() {
    super.initState();
    // Auto-fill license name
    _nameController = TextEditingController(text: widget.licenseConfig.name);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("License Details"),
          const SizedBox(height: 16),

          _buildLabel("License Name"),
          _buildTextField(_nameController, "License Name", readOnly: true),

          const SizedBox(height: 16),
          _buildLabel("License Number"),
          _buildTextField(_licenseNumberController, "Enter License / Reg Number"),

          const SizedBox(height: 16),
          _buildLabel("Issuing Authority"),
          _buildTextField(_issuingAuthorityController, "Authority Name"),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Issue Date"),
                    _buildDatePicker(_issueDateController, "Select Date"),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Expiry Date"),
                    _buildDatePicker(_expiryDateController, "Select Date"),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _buildLabel("Renewal Cycle"),
          _buildDropdown(
            value: _renewalCycle,
            items: const ['Annual', '3 Years', '5 Years'],
            onChanged: (val) => setState(() => _renewalCycle = val!),
          ),

          const SizedBox(height: 16),
          _buildLabel("Remarks (Optional)"),
          _buildTextField(_remarksController, "Any additional notes...", maxLines: 3),

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

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: RevivalColors.darkGrey,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool readOnly = false, int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        color: readOnly ? RevivalColors.softGrey : Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildDatePicker(TextEditingController controller, String hint) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        if (picked != null) {
          controller.text = "${picked.day}/${picked.month}/${picked.year}";
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IgnorePointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: const Icon(Icons.calendar_today, color: RevivalColors.primaryBlue),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: RevivalColors.primaryBlue),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
