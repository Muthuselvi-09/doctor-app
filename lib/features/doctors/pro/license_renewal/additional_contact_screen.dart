import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class AdditionalContactScreen extends StatefulWidget {
  const AdditionalContactScreen({super.key});

  @override
  State<AdditionalContactScreen> createState() => _AdditionalContactScreenState();
}

class _AdditionalContactScreenState extends State<AdditionalContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _relationship = 'Clinic Admin';
  final Map<String, bool> _permissions = {
    'Receive Reminders': true,
    'Upload Documents': false,
    'Apply for Renewal': false,
    'View Medical History': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Additional Contact'),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInstructionCard(),
            const SizedBox(height: 32),
            _buildSectionTitle('Contact Information'),
            const SizedBox(height: 16),
            _buildTextField('Full Name', _nameController, Icons.person_outline_rounded),
            const SizedBox(height: 16),
            _buildTextField('Phone Number', _phoneController, Icons.phone_android_rounded),
            const SizedBox(height: 32),
            _buildSectionTitle('Staff Role'),
            const SizedBox(height: 16),
            _buildRelationshipSelector(),
            const SizedBox(height: 32),
            _buildSectionTitle('Permissions'),
            const SizedBox(height: 16),
            _buildPermissionList(),
            const SizedBox(height: 48),
            _buildSaveButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionCard() {
    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.1)),
        ),
        child: const Text(
          'Add a trusted manager or receptionist to help manage your professional compliance and renewals.',
          style: TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
      ),
    );
  }

  Widget _buildRelationshipSelector() {
    final roles = ['Receptionist', 'Manager', 'Clinic Admin', 'Accountant'];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _relationship,
          isExpanded: true,
          onChanged: (val) => setState(() => _relationship = val!),
          items: roles.map((role) => DropdownMenuItem(value: role, child: Text(role))).toList(),
        ),
      ),
    );
  }

  Widget _buildPermissionList() {
    return Column(
      children: _permissions.keys.map((permission) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: SwitchListTile.adaptive(
            title: Text(permission, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            value: _permissions[permission]!,
            onChanged: (val) => setState(() => _permissions[permission] = val),
            activeColor: AppColors.primary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Staff contact ${_nameController.text} added!')),
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 64),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
      ),
      child: const Text('Add Staff & Assign Permissions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
