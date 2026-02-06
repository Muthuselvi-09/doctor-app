import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/theme/revival_colors.dart';

class Step1PharmacyDetails extends StatefulWidget {
  const Step1PharmacyDetails({super.key});

  @override
  State<Step1PharmacyDetails> createState() => _Step1PharmacyDetailsState();
}

class _Step1PharmacyDetailsState extends State<Step1PharmacyDetails> {
  // Controllers
  final _nameController = TextEditingController();
  final _drugLicenseController = TextEditingController();
  final _councilRegController = TextEditingController();
  final _estYearController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _areaController = TextEditingController();

  // Dropdown Values
  String? _pharmacyType;
  String? _ownershipType;
  
  // Checkboxes
  bool _hasFridge = false;
  bool _hasAC = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Pharmacy Information"),
          const SizedBox(height: 16),
          _buildTextField("Pharmacy Name", _nameController, Icons.store),
          const SizedBox(height: 12),
          _buildDropdown(
            "Pharmacy Type", 
            ["Retail", "Wholesale", "Retail + Wholesale"], 
            _pharmacyType, 
            (val) => setState(() => _pharmacyType = val)
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            "Ownership Type", 
            ["Proprietor", "Partnership", "LLP", "Pvt Ltd"], 
            _ownershipType, 
            (val) => setState(() => _ownershipType = val)
          ),
          const SizedBox(height: 12),
          _buildTextField("Drug License Number", _drugLicenseController, Icons.badge),
          const SizedBox(height: 12),
          _buildTextField("Pharmacy Council Reg. No", _councilRegController, Icons.verified),
          const SizedBox(height: 12),
          _buildTextField("Establishment Year", _estYearController, Icons.calendar_today, isNumber: true),
          
          const SizedBox(height: 24),
          _buildSectionTitle("Location & Contact"),
          const SizedBox(height: 16),
          _buildTextField("Full Address", _addressController, Icons.location_on, maxLines: 3),
          const SizedBox(height: 12),
          _buildTextField("Authorized Person Name", _contactPersonController, Icons.person),
          const SizedBox(height: 12),
          _buildTextField("Mobile Number", _mobileController, Icons.phone, isNumber: true),
          const SizedBox(height: 12),
          _buildTextField("Email ID", _emailController, Icons.email),
          
          const SizedBox(height: 24),
          _buildSectionTitle("Facility Details"),
          const SizedBox(height: 16),
          _buildTextField("Total Area (sq.m)", _areaController, Icons.aspect_ratio, isNumber: true),
          const SizedBox(height: 12),
          Text("Storage Facilities Available", style: GoogleFonts.outfit(fontSize: 14, color: RevivalColors.darkGrey)),
          const SizedBox(height: 8),
          CheckboxListTile(
            title: Text("Refrigerator / Cold Storage", style: GoogleFonts.outfit(fontSize: 14)),
            value: _hasFridge, 
            onChanged: (v) => setState(() => _hasFridge = v ?? false),
            activeColor: RevivalColors.navyBlue,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: Text("Air Conditioner (AC)", style: GoogleFonts.outfit(fontSize: 14)),
            value: _hasAC, 
            onChanged: (v) => setState(() => _hasAC = v ?? false),
            activeColor: RevivalColors.navyBlue,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          
          const SizedBox(height: 40), // Bottom padding
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: RevivalColors.navyBlue,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: RevivalColors.midGrey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: RevivalColors.midGrey.withOpacity(0.5)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
