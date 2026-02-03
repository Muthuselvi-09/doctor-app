import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';

class ProviderDetailsScreen extends StatefulWidget {
  final String licenseType;

  const ProviderDetailsScreen({super.key, required this.licenseType});

  @override
  State<ProviderDetailsScreen> createState() => _ProviderDetailsScreenState();
}

class _ProviderDetailsScreenState extends State<ProviderDetailsScreen> {
  String _entityType = 'Doctor';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text('Step 2: Provider Details', style: GoogleFonts.outfit(color: RevivalColors.deepNavy, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProgressIndicator(),
              const SizedBox(height: 32),
              Text(
                'Healthcare Provider Details',
                style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy),
              ),
              const SizedBox(height: 8),
              Text(
                'Select your entity type and confirm details.',
                style: GoogleFonts.outfit(fontSize: 14, color: RevivalColors.darkGrey),
              ),
              const SizedBox(height: 32),
              
              _buildLabel('Entity Type'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: RevivalColors.midGrey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _entityType,
                    isExpanded: true,
                    items: ['Doctor', 'Hospital / Clinic', 'Pharmacy'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: GoogleFonts.outfit(color: RevivalColors.navyBlue)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _entityType = newValue!;
                      });
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              _buildLabel('Full Name / Establishment Name'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: 'Dr. John Doe',
                decoration: _inputDecoration('Enter name'),
              ),
              
              const SizedBox(height: 24),
              _buildLabel('Establishment ID / Registration ID'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: 'REG-2024-8899',
                decoration: _inputDecoration('Enter ID'),
              ),
              
              const SizedBox(height: 24),
              _buildLabel('Address'),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 3,
                initialValue: '123 Medical Park, Health City',
                decoration: _inputDecoration('Enter full address'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to Step 3: License Details Form
            context.push('/revival-license-form', extra: widget.licenseType);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text('Next: License Details', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: RevivalColors.midGrey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: RevivalColors.midGrey)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: RevivalColors.navyBlue, width: 2)),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: GoogleFonts.outfit(fontWeight: FontWeight.w600, color: RevivalColors.deepNavy));
  }
  
  Widget _buildProgressIndicator() {
    return Row(
      children: [
        _stepDot(true), _line(true),
        _stepDot(true), _line(false), // Current Step 2
        _stepDot(false), _line(false),
        _stepDot(false), _line(false),
        _stepDot(false),
      ],
    );
  }
  
  Widget _stepDot(bool active) {
    return Container(
      width: 24, height: 24,
      decoration: BoxDecoration(
        color: active ? RevivalColors.navyBlue : RevivalColors.softGrey,
        shape: BoxShape.circle,
        border: active ? null : Border.all(color: RevivalColors.midGrey),
      ),
      child: active ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
    );
  }
  
  Widget _line(bool active) {
    return Expanded(child: Container(height: 2, color: active ? RevivalColors.navyBlue : RevivalColors.midGrey));
  }
}
