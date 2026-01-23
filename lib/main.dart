import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/splash_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/role_selection_screen.dart';
import 'features/home/home_screen.dart';
import 'features/doctors/doctor_profile_screen.dart';
import 'features/doctors/pro/doctor_dashboard.dart';
import 'features/doctors/pro/eprescription_editor.dart';
import 'features/profile/profile_screen.dart';
import 'features/institution/compliance_screen.dart';
import 'features/institution/business_verification_screen.dart';
import 'features/institution/hospital_ops_dashboard.dart';
import 'features/pharmacy/pharmacy_screen.dart';
import 'features/lab_tests/lab_tests_screen.dart';
import 'features/consultation/consultation_screen.dart';
import 'features/profile/health_records_screen.dart';
import 'features/notification/notifications_screen.dart';
import 'features/doctors/pro/license_renewal/license_overview_screen.dart';
import 'features/doctors/pro/license_renewal/renewal_requirements_screen.dart';
import 'features/doctors/pro/license_renewal/upload_preview_screen.dart';
import 'features/doctors/pro/license_renewal/fill_information_screen.dart';
import 'features/doctors/pro/license_renewal/cme_validation_screen.dart';
import 'features/doctors/pro/license_renewal/renewal_payment_screen.dart';
import 'features/doctors/pro/license_renewal/certificate_download_screen.dart';
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
      path: '/license-overview',
      builder: (context, state) => const LicenseOverviewScreen(),
    ),
    GoRoute(
      path: '/renewal-requirements',
      builder: (context, state) => const RenewalRequirementsScreen(),
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
      path: '/document-list',
      builder: (context, state) => const DocumentListScreen(),
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
