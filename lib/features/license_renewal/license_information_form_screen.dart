import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/revival_colors.dart';

class LicenseInformationFormScreen extends ConsumerStatefulWidget {
  final String licenseId;

  const LicenseInformationFormScreen({super.key, required this.licenseId});

  @override
  ConsumerState<LicenseInformationFormScreen> createState() => _LicenseInformationFormScreenState();
}

class _LicenseInformationFormScreenState extends ConsumerState<LicenseInformationFormScreen> {
  String _selectedLicenseName = 'Medical License';
  final DateTime _issueDate = DateTime(2020, 1, 1);
  final DateTime _expiryDate = DateTime(2025, 1, 1);
  
  @override
  void initState() {
    super.initState();
    _selectedLicenseName = widget.licenseId; // Pre-fill based on ID mock
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: RevivalColors.navyBlue),
          onPressed: () => context.pop(),
        ),
        title: Text('Step 3: License Details', style: GoogleFonts.outfit(color: RevivalColors.deepNavy, fontWeight: FontWeight.bold)),
        backgroundColor: RevivalColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 32),
            Text(
              'License Information',
              style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: RevivalColors.deepNavy),
            ),
             const SizedBox(height: 8),
            Text(
              'Enter the specifics of the license you are renewing.',
              style: GoogleFonts.outfit(fontSize: 14, color: RevivalColors.darkGrey),
            ),
            const SizedBox(height: 32),

            _buildLabel('License Name'),
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
                  value: _selectedLicenseName,
                  isExpanded: true,
                  // Mock items, normally dynamic based on category
                  items: {
                     _selectedLicenseName, 'Other License'
                  }.map((String value) { // toSet to avoid dups if id matches
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.outfit(color: RevivalColors.navyBlue)),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLicenseName = newValue!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),
            _buildLabel('License Number'),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'LIC-9988-7766',
              decoration: _inputDecoration('Enter license number'),
            ),

            const SizedBox(height: 24),
            _buildLabel('Issuing Authority'),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'State Medical Council',
              decoration: _inputDecoration('e.g. Health Authority'),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildDatePicker('Issue Date', _issueDate)),
                const SizedBox(width: 16),
                Expanded(child: _buildDatePicker('Expiry Date', _expiryDate)),
              ],
            ),
            
             const SizedBox(height: 24),
            _buildLabel('Renewal Period'),
            const SizedBox(height: 8),
             Row(
              children: [
                Expanded(child: _buildPeriodSelector('5 Years')),
                const SizedBox(width: 16),
                Expanded(child: _buildPeriodSelector('1 Year')),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: ElevatedButton(
          onPressed: () => context.push('/revival-document-checklist', extra: widget.licenseId),
          style: ElevatedButton.styleFrom(
            backgroundColor: RevivalColors.navyBlue,
            minimumSize: const Size(double.infinity, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Text('Next: Required Documents', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
  
  Widget _buildDatePicker(String label, DateTime date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
           decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: RevivalColors.midGrey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${date.day}/${date.month}/${date.year}', style: GoogleFonts.outfit(color: RevivalColors.navyBlue)),
              const Icon(Icons.calendar_today, size: 16, color: RevivalColors.darkGrey),
            ],
          ),
        )
      ],
    );
  }
  
  Widget _buildPeriodSelector(String label) {
    bool isSelected = label == '5 Years';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
         color: isSelected ? RevivalColors.navyBlue.withOpacity(0.1) : Colors.white,
         borderRadius: BorderRadius.circular(12),
         border: Border.all(color: isSelected ? RevivalColors.navyBlue : RevivalColors.midGrey),
      ),
      child: Center(
        child: Text(label, style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: isSelected ? RevivalColors.navyBlue : RevivalColors.darkGrey
        )),
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
        _stepDot(true), _line(true), // Step 2 done
        _stepDot(true), _line(false), // Step 3 active
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
