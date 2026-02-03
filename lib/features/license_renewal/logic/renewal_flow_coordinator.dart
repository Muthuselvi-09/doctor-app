import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RenewalFlowCoordinator {
  static void startRenewal(BuildContext context, String licenseName) {
    // Step 1 is the Overview/Dashboard where they clicked.
    // Step 2 is Provider Details.
    context.push('/revival-provider-details', extra: licenseName);
  }
  
  static void goToLicenseDetails(BuildContext context, String licenseName) {
     // Step 3
     context.push('/revival-license-form', extra: licenseName);
  }
  
  static void goToDocuments(BuildContext context, String licenseName) {
     // Step 4 & 5 (Checklist + Upload)
     context.push('/revival-document-checklist', extra: licenseName);
  }
}
