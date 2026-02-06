import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:flutter/material.dart';

class Step1ProviderDetails extends StatefulWidget {
  const Step1ProviderDetails({super.key});

  @override
  State<Step1ProviderDetails> createState() => _Step1ProviderDetailsState();
}

class _Step1ProviderDetailsState extends State<Step1ProviderDetails> {
  // Controllers
  final _hospitalNameController = TextEditingController(text: "Apollo Speciality Hospital");
  final _regNumberController = TextEditingController(text: "TN-HOSP-2023-8899");
  final _yoeController = TextEditingController(text: "1998");
  final _addressStreetController = TextEditingController(text: "32, Greams Road");
  final _addressCityController = TextEditingController(text: "Chennai");
  final _addressPincodeController = TextEditingController(text: "600006");
  final _contactNameController = TextEditingController(text: "Dr. Rajesh Kumar");
  final _mobileController = TextEditingController(text: "9876543210");
  final _emailController = TextEditingController(text: "admin@apollo.com");
  final _bedCountController = TextEditingController(text: "250");

  // Dropdown Values
  String? _hospitalType = 'Multi-specialty';
  String? _ownershipType = 'Pvt Ltd';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Hospital Basic Details"),
          const SizedBox(height: 16),
          _buildLabel("Hospital Name"),
          _buildTextField(_hospitalNameController, "Enter hospital name"),
          
          const SizedBox(height: 16),
          _buildLabel("Hospital Type"),
          _buildDropdown(
            value: _hospitalType,
            items: const ['Multi-specialty', 'Single-specialty', 'Trust', 'Govt', 'Private'],
            onChanged: (val) => setState(() => _hospitalType = val),
          ),

          const SizedBox(height: 16),
          _buildLabel("Ownership Type"),
          _buildDropdown(
            value: _ownershipType,
            items: const ['Trust', 'LLP', 'Pvt Ltd', 'Partnership'],
            onChanged: (val) => setState(() => _ownershipType = val),
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Registration Number"),
                    _buildTextField(_regNumberController, "Reg No."),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Year of Est."),
                    _buildTextField(_yoeController, "YYYY", keyboardType: TextInputType.number),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
          _buildSectionTitle("Address & Contact"),

          const SizedBox(height: 16),
          _buildLabel("Street Address"),
          _buildTextField(_addressStreetController, "Door No, Street Name"),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("City"),
                    _buildTextField(_addressCityController, "City"),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Pincode"),
                    _buildTextField(_addressPincodeController, "600000", keyboardType: TextInputType.number),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _buildLabel("Contact Person Name"),
          _buildTextField(_contactNameController, "Name"),

          const SizedBox(height: 16),
          _buildLabel("Designation"),
          _buildTextField(TextEditingController(text: "Medical Director"), "Designation"),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Mobile Number"),
                    _buildTextField(_mobileController, "10-digit mobile", keyboardType: TextInputType.phone),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Total Bed Count"),
                    _buildTextField(_bedCountController, "Num", keyboardType: TextInputType.number),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          _buildLabel("Email ID"),
          _buildTextField(_emailController, "email@domain.com", keyboardType: TextInputType.emailAddress),
          
          const SizedBox(height: 32), // Bottom padding
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

  Widget _buildTextField(TextEditingController controller, String hint, {TextInputType? keyboardType}) {
    return Container(
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
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
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

  Widget _buildDropdown({
    required String? value,
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
