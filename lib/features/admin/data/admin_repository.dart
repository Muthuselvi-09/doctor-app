import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/admin_models.dart';

class AdminRepository {
  // Mock Data Store
  final List<LicenseApplication> _applications = [
    LicenseApplication(
      id: 'REQ-2024-001',
      userId: 'USR-101',
      userName: 'Dr. John Doe',
      userType: 'Doctor',
      licenseNumber: 'MED-1234-5678',
      type: ApplicationType.medicalLicense,
      status: ApplicationStatus.received,
      submissionDate: DateTime.now().subtract(const Duration(days: 2)),
      documents: [
        LicenseDocument(id: 'DOC-1', name: 'Medical Degree.pdf', url: 'path/to/doc1'),
        LicenseDocument(id: 'DOC-2', name: 'ID Proof.jpg', url: 'path/to/doc2'),
      ],
    ),
    LicenseApplication(
      id: 'REQ-2024-002',
      userId: 'USR-102',
      userName: 'City Care Hospital',
      userType: 'Hospital',
      licenseNumber: 'HOSP-9876',
      type: ApplicationType.hospitalLicense,
      status: ApplicationStatus.underVerification,
      submissionDate: DateTime.now().subtract(const Duration(days: 5)),
      documents: [
        LicenseDocument(id: 'DOC-3', name: 'Fire Safety Cert.pdf', url: 'path/to/doc3', status: DocumentStatus.verified),
        LicenseDocument(id: 'DOC-4', name: 'Pollution Control.pdf', url: 'path/to/doc4', status: DocumentStatus.pending),
      ],
    ),
    LicenseApplication(
      id: 'REQ-2024-003',
      userId: 'USR-103',
      userName: 'Dr. Sarah Smith',
      userType: 'Doctor',
      licenseNumber: 'CLINIC-4545',
      type: ApplicationType.clinicRegistration,
      status: ApplicationStatus.appliedExternally,
      submissionDate: DateTime.now().subtract(const Duration(days: 10)),
      externalApplicationNumber: 'GOVT-APP-0099',
      expectedApprovalDate: DateTime.now().add(const Duration(days: 15)),
      documents: [
         LicenseDocument(id: 'DOC-5', name: 'Establishment Act.pdf', url: 'path/to/doc5', status: DocumentStatus.verified),
      ],
    ),
    LicenseApplication(
      id: 'REQ-2024-004',
      userId: 'USR-104',
      userName: 'Green Cross Pharmacy',
      userType: 'Pharmacy',
      licenseNumber: 'PHARM-1122',
      type: ApplicationType.pharmacyLicense,
      status: ApplicationStatus.approved,
      submissionDate: DateTime.now().subtract(const Duration(days: 20)),
      certificateUrl: 'path/to/certificate.pdf',
      documents: [],
    ),
      LicenseApplication(
      id: 'REQ-2024-005',
      userId: 'USR-105',
      userName: 'Dr. Emily White',
      userType: 'Doctor',
      licenseNumber: 'MED-5555-4444',
      type: ApplicationType.medicalLicense,
      status: ApplicationStatus.rejected,
      rejectionReason: 'Invalid Document Provided',
      submissionDate: DateTime.now().subtract(const Duration(days: 1)),
      documents: [
         LicenseDocument(id: 'DOC-6', name: 'Medical Degree.pdf', url: 'path/to/doc6', status: DocumentStatus.rejected, adminRemark: 'Blurry Image'),
      ],
    ),
  ];

  Future<AdminStats> getDashboardStats() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate net
    return const AdminStats(
      totalDoctors: 1240,
      pendingReviews: 14, // Matches mock
      revenue: 12500,
      issues: 3,
      verifiedToday: 8,
      expiringAlerts: 3,
    );
  }

  Future<List<LicenseApplication>> getAllApplications() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _applications;
  }

  Future<LicenseApplication?> getApplicationById(String id) async {
     await Future.delayed(const Duration(milliseconds: 300));
     try {
       return _applications.firstWhere((app) => app.id == id);
     } catch (e) {
       return null;
     }
  }

  Future<void> updateApplicationStatus(String appId, ApplicationStatus newStatus, {
    String? externalAppNum,
    DateTime? expectedDate,
    String? rejectionReason,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _applications.indexWhere((app) => app.id == appId);
    if (index != -1) {
      _applications[index] = _applications[index].copyWith(
        status: newStatus,
        externalApplicationNumber: externalAppNum,
        expectedApprovalDate: expectedDate,
        rejectionReason: rejectionReason,
      );
    }
  }

  Future<void> updateDocumentStatus(String appId, String docId, DocumentStatus newStatus, {String? remark}) async {
     await Future.delayed(const Duration(milliseconds: 400));
     final appIndex = _applications.indexWhere((app) => app.id == appId);
     if (appIndex != -1) {
       final app = _applications[appIndex];
       final docIndex = app.documents.indexWhere((d) => d.id == docId);
       if (docIndex != -1) {
         final updatedDocs = List<LicenseDocument>.from(app.documents);
         updatedDocs[docIndex] = updatedDocs[docIndex].copyWith(
           status: newStatus,
           adminRemark: remark,
         );
         _applications[appIndex] = app.copyWith(documents: updatedDocs);
       }
     }
  }
  
  Future<void> uploadCertificate(String appId, String certificatePath) async {
    await Future.delayed(const Duration(milliseconds: 1000));
     final index = _applications.indexWhere((app) => app.id == appId);
    if (index != -1) {
      _applications[index] = _applications[index].copyWith(
        certificateUrl: certificatePath,
        status: ApplicationStatus.approved,
      );
    }
  }
}

final adminRepositoryProvider = Provider<AdminRepository>((ref) => AdminRepository());
