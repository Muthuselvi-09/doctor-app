import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class FillInformationScreen extends StatefulWidget {
  const FillInformationScreen({super.key});

  @override
  State<FillInformationScreen> createState() => _FillInformationScreenState();
}

class _FillInformationScreenState extends State<FillInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Fields
  final TextEditingController _nameController = TextEditingController(text: 'Dr. Sarah Morgan');
  String _qualification = 'MBBS';
  final TextEditingController _specialtyController = TextEditingController(text: 'General Physician');
  final TextEditingController _passingYearController = TextEditingController(text: '2015');
  final TextEditingController _regYearController = TextEditingController(text: '2016');
  final TextEditingController _cmeHoursController = TextEditingController(text: '30');
  String _practiceType = 'Private Clinic';
  final TextEditingController _addressController = TextEditingController(text: '123 Medical Park, Suite 400, NY');
  final TextEditingController _altContactController = TextEditingController(text: 'Sarah (Receptionist)');
  final TextEditingController _ccEmailController = TextEditingController(text: 'sarah.reception@clinic.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Professional Information'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGlassSection([
                _buildTextField('Full Name', _nameController, Icons.person_outline_rounded),
                const SizedBox(height: 16),
                _buildDropdownField('Qualification', _qualification, ['MBBS', 'MD', 'MS', 'DNB', 'PhD'], (val) => setState(() => _qualification = val!)),
                const SizedBox(height: 16),
                _buildTextField('Specialty', _specialtyController, Icons.medical_services_outlined),
              ]),
              const SizedBox(height: 32),
              _buildSectionHeader('Registration Details'),
              _buildGlassSection([
                Row(
                  children: [
                    Expanded(child: _buildTextField('Passing Year', _passingYearController, Icons.calendar_today_rounded, isNumeric: true)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('Reg. Year', _regYearController, Icons.history_rounded, isNumeric: true)),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField('CME Hours Completed', _cmeHoursController, Icons.timer_outlined, isNumeric: true),
              ]),
              const SizedBox(height: 32),
              _buildSectionHeader('Practice Information'),
              _buildGlassSection([
                _buildDropdownField('Practice Type', _practiceType, ['Private Clinic', 'Government Hospital', 'Private Hospital', 'Consultant'], (val) => setState(() => _practiceType = val!)),
                const SizedBox(height: 16),
                _buildTextField('Practice Address', _addressController, Icons.location_on_outlined, maxLines: 2),
              ]),
              const SizedBox(height: 32),
              _buildSectionHeader('Administrative Contact'),
              _buildGlassSection([
                _buildTextField('Alternate Contact', _altContactController, Icons.support_agent_rounded),
                const SizedBox(height: 16),
                _buildTextField('Email for CC', _ccEmailController, Icons.mail_outline_rounded),
              ]),
              const SizedBox(height: 48),
              _buildNextButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildGlassSection(List<Widget> children) {
    return FadeInUp(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {bool isNumeric = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
            filled: true,
            fillColor: AppColors.background.withOpacity(0.5),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      onPressed: () => context.push('/validate-cme'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        shadowColor: AppColors.primary.withOpacity(0.4),
      ),
      child: const Text('Save & Continue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
