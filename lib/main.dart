import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/role_selection_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/screens/user_dashboard_screen.dart';
import 'features/dashboard/screens/portal_selection_screen.dart';
import 'features/documents/screens/master_vault_screen.dart';
import 'features/admin/presentation/screens/admin_login_screen.dart';
import 'features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'features/admin/presentation/screens/application_review_screen.dart';
import 'features/admin/presentation/screens/license_requests_screen.dart';
import 'features/common/screens/invoice_list_screen.dart';
import 'features/common/screens/payment_screen.dart';
import 'features/profile/screens/personal_details_screen.dart';
import 'features/settings/screens/reminder_settings_screen.dart';
import 'features/home/home_screen.dart';
import 'features/doctors/doctor_profile_screen.dart';
import 'features/doctors/pro/doctor_dashboard.dart';
import 'features/profile/profile_screen.dart';
import 'features/institution/hospital_ops_dashboard.dart';
import 'features/pharmacy/pharmacy_screen.dart';
import 'features/lab_tests/lab_tests_screen.dart';
import 'features/consultation/consultation_screen.dart';
import 'features/profile/health_records_screen.dart';
import 'features/doctors/pro/license_renewal/license_overview_screen.dart';
import 'features/doctors/pro/license_renewal/upload_preview_screen.dart';
import 'features/doctors/pro/license_renewal/fill_information_screen.dart';
import 'features/doctors/pro/license_renewal/cme_validation_screen.dart';
import 'features/doctors/pro/license_renewal/renewal_payment_screen.dart';
import 'features/doctors/pro/license_renewal/certificate_download_screen.dart';
import 'features/doctors/pro/license_renewal/submission_review_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_requirements_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_upload_screen.dart';
import 'features/doctors/pro/practice_renewal/establishment_details_screen.dart';
import 'features/doctors/pro/practice_renewal/compliance_safety_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_summary_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_payment_screen.dart';
import 'features/doctors/pro/practice_renewal/inspection_tracking_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_status_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_certificate_screen.dart';
import 'features/doctors/pro/practice_renewal/practice_reminder_screen.dart';
import 'features/doctors/pro/license_renewal/renewal_tracking_screen.dart';
import 'features/doctors/pro/future_modules_screen.dart';
import 'features/institution/hospital_dashboard_screen.dart';
import 'features/pharmacy/pharmacy_placeholder_screen.dart';
import 'features/doctors/pro/compliance/compliance_category_detail_screen.dart';
import 'features/doctors/pro/compliance/compliance_calendar_screen.dart';
import 'features/doctors/pro/license_renewal/reminder_scheduler_screen.dart';
import 'features/doctors/pro/license_renewal/additional_contact_screen.dart';
import 'features/doctors/pro/compliance/document_viewer_screen.dart';
import 'features/doctors/pro/compliance/document_list_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/license_renewal/doctor_dashboard_screen.dart';
import 'features/license_renewal/service_overview_screen.dart';
import 'features/license_renewal/master_profile_screen.dart';
import 'features/license_renewal/document_upload_screen.dart';
import 'features/license_renewal/reminder_setup_screen.dart';
import 'features/license_renewal/review_lock_screen.dart';
import 'features/license_renewal/workflow_tracker_screen.dart';
import 'features/license_renewal/completion_screen.dart';
import 'features/license_renewal/eligibility_rules_screen.dart';
import 'features/license_renewal/document_checklist_screen.dart';
import 'features/license_renewal/upload_update_screen.dart';
import 'features/license_renewal/review_consent_screen.dart';
import 'features/license_renewal/tracking_visual_screen.dart';
import 'features/license_renewal/renewal_history_screen.dart';
import 'features/license_renewal/cme_dashboard_screen.dart';
import 'features/license_renewal/cme_upload_screen.dart';
import 'features/license_renewal/eprescription_eligibility_screen.dart';
import 'features/license_renewal/eprescription_mapping_screen.dart';
import 'features/license_renewal/eprescription_confirmation_screen.dart';
import 'features/license_renewal/license_information_form_screen.dart';
import 'features/license_renewal/screens/flow/provider_details_screen.dart';
import 'features/license_renewal/advance_reminder_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/admin-login',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      path: '/admin-dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
    GoRoute(
      path: '/admin-review',
      builder: (context, state) {
        final appId = state.extra as String?;
        return ApplicationReviewScreen(applicationId: appId);
      },
    ),
    GoRoute(
      path: '/admin-license-requests',
      builder: (context, state) => const LicenseRequestsScreen(),
    ),
    GoRoute(
      path: '/portal-selection',
      builder: (context, state) => const PortalSelectionScreen(),
    ),
    GoRoute(
      path: '/master-vault',
      builder: (context, state) => const MasterVaultScreen(),
    ),
    GoRoute(
      path: '/user-dashboard',
      builder: (context, state) {
        final int initialIndex = state.extra as int? ?? 0;
        return UserDashboardScreen(initialIndex: initialIndex);
      },
    ),
    GoRoute(
      path: '/doctor-dashboard',
      builder: (context, state) => const DoctorDashboard(),
    ),
    GoRoute(
      path: '/hospital-dashboard',
      builder: (context, state) => const HospitalOpsDashboard(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/doctor-profile',
      builder: (context, state) => const DoctorProfileScreen(),
    ),
    GoRoute(
      path: '/pharmacy',
      builder: (context, state) => const PharmacyScreen(),
    ),
    GoRoute(
      path: '/lab-tests',
      builder: (context, state) => const LabTestScreen(),
    ),
    GoRoute(
      path: '/consultation',
      builder: (context, state) => const ConsultationScreen(),
    ),
    GoRoute(
      path: '/health-records',
      builder: (context, state) => const HealthRecordsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/revival-license-overview',
      builder: (context, state) => const LicenseOverviewScreen(),
    ),
    GoRoute(
      path: '/revival-eligibility-rules',
      builder: (context, state) => const EligibilityRulesScreen(),
    ),
    GoRoute(
      path: '/revival-license-form',
      builder: (context, state) {
        final licenseId = state.extra as String? ?? 'med_renewal';
        return LicenseInformationFormScreen(licenseId: licenseId);
      },
    ),
    GoRoute(
      path: '/revival-provider-details',
      builder: (context, state) {
         final licenseType = state.extra as String? ?? 'Doctor';
         return ProviderDetailsScreen(licenseType: licenseType);
      },
    ),
    GoRoute(
      path: '/revival-advance-reminder',
      builder: (context, state) => const AdvanceReminderScreen(),
    ),
    GoRoute(
      path: '/revival-document-checklist',
      builder: (context, state) {
        final licenseId = state.extra as String? ?? 'med_renewal';
        return DocumentChecklistScreen(licenseId: licenseId);
      },
    ),
    GoRoute(
      path: '/revival-upload-update',
      builder: (context, state) {
        String docTitle = 'Document Upload';
        String? docId;
        
        if (state.extra is Map) {
          final map = state.extra as Map;
          docTitle = map['title'] ?? 'Document Upload';
          docId = map['id'];
        } else if (state.extra is String) {
          docTitle = state.extra as String;
        }
        
        return UploadUpdateScreen(documentTitle: docTitle, documentId: docId);
      },
    ),
    GoRoute(
      path: '/revival-review-consent',
      builder: (context, state) => const ReviewConsentScreen(),
    ),
    GoRoute(
      path: '/revival-tracking-visual',
      builder: (context, state) => const TrackingVisualScreen(),
    ),
    GoRoute(
      path: '/revival-renewal-history',
      builder: (context, state) => const RenewalHistoryScreen(),
    ),
    GoRoute(
      path: '/upload-preview',
      builder: (context, state) {
        final docTitle = state.extra as String? ?? 'Document Upload';
        return UploadPreviewScreen(documentTitle: docTitle);
      },
    ),
    GoRoute(
      path: '/submission-review',
      builder: (context, state) => const SubmissionReviewScreen(),
    ),
    GoRoute(
      path: '/renewal-tracking',
      builder: (context, state) => const RenewalTrackingScreen(),
    ),
    GoRoute(
      path: '/fill-info',
      builder: (context, state) => const FillInformationScreen(),
    ),
    GoRoute(
      path: '/validate-cme',
      builder: (context, state) => const CMEValidationScreen(),
    ),
    GoRoute(
      path: '/revival-cme-dashboard',
      builder: (context, state) => const CMEDashboardScreen(),
    ),
    GoRoute(
      path: '/revival-cme-upload',
      builder: (context, state) => const CMEUploadScreen(),
    ),
    GoRoute(
      path: '/revival-eprescription-eligibility',
      builder: (context, state) => const EPrescriptionEligibilityScreen(),
    ),
    GoRoute(
      path: '/revival-eprescription-mapping',
      builder: (context, state) => const EPrescriptionMappingScreen(),
    ),
    GoRoute(
      path: '/revival-eprescription-confirmation',
      builder: (context, state) => const EPrescriptionConfirmationScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => const RenewalPaymentScreen(),
    ),
    GoRoute(
      path: '/certificate-download',
      builder: (context, state) => const CertificateDownloadScreen(),
    ),
    GoRoute(
      path: '/practice-requirements',
      builder: (context, state) => const PracticeRequirementsScreen(),
    ),
    GoRoute(
      path: '/practice-upload',
      builder: (context, state) => const PracticeUploadScreen(),
    ),
    GoRoute(
      path: '/practice-details',
      builder: (context, state) => const EstablishmentDetailsScreen(),
    ),
    GoRoute(
      path: '/compliance-safety',
      builder: (context, state) => const ComplianceSafetyScreen(),
    ),
    GoRoute(
      path: '/practice-summary',
      builder: (context, state) => const PracticeSummaryScreen(),
    ),
    GoRoute(
      path: '/practice-payment',
      builder: (context, state) => const PracticePaymentScreen(),
    ),
    GoRoute(
      path: '/practice-inspection',
      builder: (context, state) => const InspectionTrackingScreen(),
    ),
    GoRoute(
      path: '/practice-status',
      builder: (context, state) => const PracticeStatusScreen(),
    ),
    GoRoute(
      path: '/practice-certificate',
      builder: (context, state) => const PracticeCertificateScreen(),
    ),
    GoRoute(
      path: '/practice-reminder',
      builder: (context, state) => const PracticeReminderScreen(),
    ),
    GoRoute(
      path: '/future-modules',
      builder: (context, state) {
        final moduleTitle = state.extra as String? ?? 'Module';
        return FutureModulesScreen(moduleName: moduleTitle);
      },
    ),
    GoRoute(
      path: '/hospital-placeholder',
      builder: (context, state) => const HospitalDashboardScreen(),
    ),
    GoRoute(
      path: '/pharmacy-placeholder',
      builder: (context, state) => const PharmacyPlaceholderScreen(),
    ),
    GoRoute(
      path: '/compliance-detail',
      builder: (context, state) {
        final category = state.extra as String? ?? 'Compliance Detail';
        return ComplianceCategoryDetailScreen(categoryName: category);
      },
    ),
    GoRoute(
      path: '/compliance-calendar',
      builder: (context, state) => const ComplianceCalendarScreen(),
    ),
    GoRoute(
      path: '/reminder-scheduler',
      builder: (context, state) => const ReminderSchedulerScreen(),
    ),
    GoRoute(
      path: '/additional-contact',
      builder: (context, state) => const AdditionalContactScreen(),
    ),
    GoRoute(
      path: '/document-viewer',
      builder: (context, state) {
        final docTitle = state.extra as String? ?? 'Document';
        return DocumentViewerScreen(documentTitle: docTitle);
      },
    ),
    GoRoute(
      path: '/revival-document-list',
      builder: (context, state) => const DocumentListScreen(),
    ),
    GoRoute(
      path: '/revival-master-vault',
      builder: (context, state) => const MasterVaultScreen(),
    ),
    // Doctor Revival Routes
    GoRoute(
      path: '/revival-portal-selection',
      builder: (context, state) => const PortalSelectionScreen(),
    ),
    GoRoute(
      path: '/revival-doctor-dashboard',
      builder: (context, state) => const DoctorDashboardScreen(),
    ),
    GoRoute(
      path: '/revival-service-overview',
      builder: (context, state) => const ServiceOverviewScreen(),
    ),
    GoRoute(
      path: '/revival-master-profile',
      builder: (context, state) => const MasterProfileScreen(),
    ),
    GoRoute(
      path: '/revival-document-upload',
      builder: (context, state) => const DocumentUploadScreen(),
    ),
    GoRoute(
      path: '/revival-reminder-setup',
      builder: (context, state) => const ReminderSetupScreen(),
    ),
    GoRoute(
      path: '/revival-review-lock',
      builder: (context, state) => const ReviewLockScreen(),
    ),
    GoRoute(
      path: '/revival-workflow-tracker',
      builder: (context, state) => const WorkflowTrackerScreen(),
    ),
    GoRoute(
      path: '/revival-completion',
      builder: (context, state) => const CompletionScreen(),
    ),
    GoRoute(
      path: '/invoices',
      builder: (context, state) => const InvoiceListScreen(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final id = state.extra as String?;
        return PaymentScreen(invoiceId: id);
      },
    ),
    GoRoute(
      path: '/personal-details',
      builder: (context, state) => const PersonalDetailsScreen(),
    ),
    GoRoute(
      path: '/reminder-settings',
      builder: (context, state) => const ReminderSettingsScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Doctor Revival',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}
