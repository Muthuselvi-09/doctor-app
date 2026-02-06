import 'package:doctor_app/core/theme/revival_colors.dart';
import 'package:doctor_app/features/hospital/license_renewal/domain/models/hospital_license_config.dart';
import 'package:flutter/material.dart';

import 'steps/step_1_provider_details.dart';
import 'steps/step_2_license_details.dart';
import 'steps/step_3_documents_upload.dart';
import 'steps/step_4_reminder_setup.dart';
import 'steps/step_5_review_confirm.dart';
import 'steps/step_6_submission_success.dart';

class HospitalRenewalStepperScreen extends StatefulWidget {
  final HospitalLicenseConfig licenseConfig;

  const HospitalRenewalStepperScreen({super.key, required this.licenseConfig});

  @override
  State<HospitalRenewalStepperScreen> createState() => _HospitalRenewalStepperScreenState();
}

class _HospitalRenewalStepperScreenState extends State<HospitalRenewalStepperScreen> {
  int _currentStep = 0;

  // Global Key to managing validation or state if needed, but for now we keep it simple
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text(widget.licenseConfig.name), // Dynamic Title
        backgroundColor: RevivalColors.navyBlue,
        iconTheme: const IconThemeData(color: RevivalColors.white),
        titleTextStyle: const TextStyle(color: RevivalColors.white, fontSize: 18),
      ),
      body: Column(
        children: [
          _buildStepperHeader(),
          Expanded(
            child: _buildCurrentStep(),
          ),
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildStepperHeader() {
    // Custom Horizontal Stepper Header
    // For simplicity sake, we can implement a row of icons/dots
    final steps = ["Provider", "License", "Docs", "Remind", "Review"];
    
    return Container(
      color: RevivalColors.white,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: List.generate(steps.length, (index) {
          bool isActive = index == _currentStep;
          bool isCompleted = index < _currentStep;
          
          return Expanded(
            child: Column(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive ? RevivalColors.primaryBlue : (isCompleted ? RevivalColors.success : RevivalColors.midGrey),
                    border: Border.all(
                      color: isActive ? RevivalColors.primaryBlue : (isCompleted ? RevivalColors.success : RevivalColors.midGrey),
                    ),
                  ),
                  child: Center(
                    child: isCompleted 
                        ? const Icon(Icons.check, size: 16, color: Colors.white)
                        : Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: isActive ? Colors.white : RevivalColors.darkGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  steps[index],
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive ? RevivalColors.primaryBlue : RevivalColors.darkGrey,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    // Switch case to return appropriate step widget
    switch (_currentStep) {
      case 0:
        return const Step1ProviderDetails();
      case 1:
        return Step2LicenseDetails(licenseConfig: widget.licenseConfig);
      case 2:
        return Step3DocumentsUpload(licenseConfig: widget.licenseConfig);
      case 3:
        return const Step4ReminderSetup();
      case 4:
        return Step5ReviewConfirm(
          licenseConfig: widget.licenseConfig,
          onEditProvider: () => setState(() => _currentStep = 0),
          onEditLicense: () => setState(() => _currentStep = 1),
          onEditDocs: () => setState(() => _currentStep = 2),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: RevivalColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: RevivalColors.navyBlue,
                  side: const BorderSide(color: RevivalColors.navyBlue),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Back"),
              ),
            ),
          if (_currentStep > 0)
            const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                if (_currentStep < 4) {
                  setState(() {
                    _currentStep++;
                  });
                } else {
                  // Submit action
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const SubmissionSuccessScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RevivalColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(_currentStep == 4 ? "Confirm & Submit" : "Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
