import 'package:flutter/material.dart';
import '../../../../../../core/theme/revival_colors.dart';
import '../../domain/models/pharmacy_license_config.dart';

// Steps
import 'steps/step_1_pharmacy_details.dart';
import 'steps/step_2_pharmacy_license_details.dart';
import 'steps/step_3_pharmacy_documents.dart';
import 'steps/step_4_pharmacy_reminder.dart';
import 'steps/step_5_pharmacy_review.dart';
import 'steps/step_6_pharmacy_success.dart';

class PharmacyRenewalStepperScreen extends StatefulWidget {
  final PharmacyLicenseConfig licenseConfig;

  const PharmacyRenewalStepperScreen({super.key, required this.licenseConfig});

  @override
  State<PharmacyRenewalStepperScreen> createState() => _PharmacyRenewalStepperScreenState();
}

class _PharmacyRenewalStepperScreenState extends State<PharmacyRenewalStepperScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        title: Text(widget.licenseConfig.name), // Dynamic Title from Config
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
    switch (_currentStep) {
      case 0:
        return const Step1PharmacyDetails();
      case 1:
        return Step2PharmacyLicenseDetails(licenseConfig: widget.licenseConfig);
      case 2:
        return Step3PharmacyDocuments(licenseConfig: widget.licenseConfig);
      case 3:
        return const Step4PharmacyReminder(); 
      case 4:
        return Step5PharmacyReview(
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
                  // Submit action -> Proceed to Success
                  Navigator.pushReplacement(
                    context, 
                    MaterialPageRoute(builder: (context) => const Step6PharmacySuccess()), // From placeholders
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
