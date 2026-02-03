import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class EstablishmentDetailsScreen extends StatefulWidget {
  const EstablishmentDetailsScreen({super.key});

  @override
  State<EstablishmentDetailsScreen> createState() => _EstablishmentDetailsScreenState();
}

class _EstablishmentDetailsScreenState extends State<EstablishmentDetailsScreen> {
  String _establishmentType = 'OP Clinic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Establishment Details'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Basic Information'),
            const SizedBox(height: 16),
            _buildTextField('Clinic/Practice Name', Icons.home_work_rounded),
            _buildTextField('Registration Number', Icons.app_registration_rounded),
            _buildDropdownField('Establishment Type', Icons.category_rounded, ['OP Clinic', 'Multi-Specialty', 'Lab Attached']),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Operational Details'),
            const SizedBox(height: 16),
            _buildTextField('Full Address', Icons.location_on_rounded, maxLines: 3),
            _buildTextField('Operating Hours', Icons.access_time_filled_rounded, hint: 'e.g. 09:00 AM - 08:00 PM'),
            _buildTextField('Practice Services Offered', Icons.medical_services_rounded, hint: 'e.g. General Medicine, Pediatrics'),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Ownership & Contact'),
            const SizedBox(height: 16),
            _buildTextField('Owner Name', Icons.person_rounded),
            _buildTextField('Contact Number', Icons.phone_rounded),
            _buildTextField('Alt Contact (Receptionist/Mgr)', Icons.support_agent_rounded),
            _buildTextField('Notification Email', Icons.email_rounded),
            
            const SizedBox(height: 32),
            _buildSectionTitle('Premises & Compliance'),
            const SizedBox(height: 16),
            _buildTextField('Premises Size (Sq Ft)', Icons.square_foot_rounded),
            _buildTextField('Facilities', Icons.meeting_room_rounded, hint: 'Waiting, Consultation, Procedure rooms'),
            _buildTextField('Biomedical Vendor Details', Icons.delete_sweep_rounded),
            _buildTextField('GST Information (Optional)', Icons.receipt_long_rounded),
            
            const SizedBox(height: 48),
            _buildNextButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return FadeInLeft(
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1, String? hint}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          floatingLabelStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, IconData icon, List<String> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _establishmentType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
          border: InputBorder.none,
          labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontSize: 14)),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() => _establishmentType = newValue!);
        },
      ),
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () => context.push('/compliance-safety'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        shadowColor: AppColors.primary.withOpacity(0.4),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Compliance & Safety', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(width: 12),
          Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}
