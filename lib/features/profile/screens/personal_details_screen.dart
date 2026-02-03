import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class PersonalDetailsScreen extends StatelessWidget {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text('Personal Details', style: GoogleFonts.outfit(color: RevivalColors.deepNavy, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: RevivalColors.deepNavy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
             _buildSectionTitle('Contact Information'),
             const SizedBox(height: 16),
             _buildTextField('Full Name', 'Dr. John Doe'),
             const SizedBox(height: 16),
             _buildTextField('Email Address', 'doctor@example.com'),
             const SizedBox(height: 16),
             _buildTextField('Mobile Number', '+91 98765 43210'),
             const SizedBox(height: 32),
             _buildSectionTitle('Billing Details'),
             const SizedBox(height: 16),
             _buildTextField('City', 'Bangalore'),
             const SizedBox(height: 16),
             _buildTextField('Address Line 1', '123 Health Ave'),
             const SizedBox(height: 16),
             _buildTextField('GSTIN (Optional)', ''),
             
             const SizedBox(height: 40),
             SizedBox(
               width: double.infinity,
               height: 56,
               child: ElevatedButton(
                 onPressed: () {},
                 style: ElevatedButton.styleFrom(
                   backgroundColor: RevivalColors.navyBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                 ),
                 child: Text('Save Changes', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold)),
               ),
             ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy)),
    );
  }

  Widget _buildTextField(String label, String value) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}
