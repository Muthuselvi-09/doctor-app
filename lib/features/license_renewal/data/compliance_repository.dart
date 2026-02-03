import 'dart:async';
import '../domain/models/compliance_models.dart';

class ComplianceRepository {
  // Mock data for initial implementation
  final List<LicenseService> _services = [
    LicenseService(
      id: 'med_renewal',
      title: 'Medical License Renewal',
      description: 'Medical council license renewal (MCI/SMC)',
      registrationNumber: 'MC-12345',
      medicalCouncil: 'State Medical Council',
      status: LicenseStatus.expiring,
      issueDate: DateTime(2021, 10, 24),
      expiryDate: DateTime(2026, 10, 24),
      requiredDocumentIds: ['doc_degree', 'doc_id', 'doc_reg_cert', 'doc_passport_photo'],
      formFields: [
        LicenseFormField(label: 'Full Name', hint: 'As per Council Records', value: 'Dr. Anya Sharma'),
        LicenseFormField(label: 'Medical Council', hint: 'e.g., Delhi Medical Council', value: 'Delhi Medical Council'),
        LicenseFormField(label: 'Registration Number', hint: 'License Number', value: 'MC-12345'),
        LicenseFormField(label: 'Specialization', hint: 'e.g., Cardiology', value: 'Cardiology'),
        LicenseFormField(label: 'Email', hint: 'Professional Email', value: 'anya.sharma@hospital.com'),
        LicenseFormField(label: 'Address', hint: 'Clinic/Hospital Address', value: 'Sector 42, New Delhi'),
      ],
    ),
    LicenseService(
      id: 'practice_renewal',
      title: 'Practice License Renewal',
      description: 'Private practice/Clinic permit renewal',
      status: LicenseStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 340)),
      requiredDocumentIds: ['doc_id', 'doc_practice_cert'],
      formFields: [
        LicenseFormField(label: 'Establishment Name', hint: 'Name of the Clinic'),
        LicenseFormField(label: 'Permit Number', hint: 'Operating Permit ID'),
        LicenseFormField(label: 'Owner Name', hint: 'Lead Doctor'),
        LicenseFormField(label: 'Address', hint: 'Clinic Location'),
      ],
    ),
    LicenseService(
      id: 'clinic_renewal',
      title: 'Clinic License Renewal',
      description: 'Clinical establishment registration',
      status: LicenseStatus.pendingSubmission,
      requiredDocumentIds: ['doc_id', 'doc_clinic_blueprint', 'doc_fsc'],
    ),
    LicenseService(
      id: 'hospital_renewal',
      title: 'Hospital License Renewal',
      description: 'Hospital operational license',
      status: LicenseStatus.pendingSubmission,
      requiredDocumentIds: ['doc_id', 'doc_hospital_accreditation'],
    ),
    LicenseService(
      id: 'speciality_renewal',
      title: 'Speciality License Renewal',
      description: 'Post-graduate speciality registration',
      status: LicenseStatus.pendingSubmission,
      requiredDocumentIds: ['doc_degree_pg', 'doc_id', 'doc_reg_cert'],
    ),
    LicenseService(
      id: 'indemnity_renewal',
      title: 'Medical Indemnity Insurance',
      description: 'Professional liability insurance renewal',
      status: LicenseStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 180)),
    ),
    LicenseService(
      id: 'cme_credits',
      title: 'CME Credits Management',
      description: 'Continuing Medical Education tracking',
      status: LicenseStatus.active,
      requiredDocumentIds: ['doc_degree'],
    ),
    LicenseService(
      id: 'eprescription',
      title: 'E-Prescription License',
      description: 'Digital prescription authorization',
      status: LicenseStatus.active,
      expiryDate: DateTime.now().add(const Duration(days: 450)),
    ),
  ];

  final List<LicenseDocument> _documents = [
    LicenseDocument(
      id: 'doc_degree',
      name: 'MBBS/MD Degree Copy',
      category: 'Qualification',
      status: DocumentStatus.verified,
      uploadDate: DateTime.now().subtract(const Duration(days: 400)),
      linkedLicenseTypes: ['med_renewal', 'speciality_renewal'],
    ),
    LicenseDocument(
      id: 'doc_id',
      name: 'Government ID Proof',
      category: 'Identity',
      status: DocumentStatus.verified,
      uploadDate: DateTime.now().subtract(const Duration(days: 400)),
      linkedLicenseTypes: ['med_renewal', 'practice_renewal', 'clinic_renewal'],
    ),
    LicenseDocument(
      id: 'doc_reg_cert',
      name: 'Medical Council Registration',
      category: 'Qualification',
      status: DocumentStatus.verified,
      uploadDate: DateTime.now().subtract(const Duration(days: 400)),
      linkedLicenseTypes: ['med_renewal'],
    ),
    LicenseDocument(
      id: 'doc_passport_photo',
      name: 'Passport Size Photo',
      category: 'Identity',
      status: DocumentStatus.verified,
      uploadDate: DateTime.now().subtract(const Duration(days: 100)),
      linkedLicenseTypes: ['med_renewal', 'practice_renewal'],
    ),
  ];

  Future<List<LicenseService>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _services;
  }

  Future<LicenseRequirement?> getRequirement(String licenseTypeId) async {
    final service = _services.firstWhere((s) => s.id == licenseTypeId);
    return LicenseRequirement(
      licenseTypeId: service.id,
      introduction: 'Renew your ${service.title} through our expert verification and filing service.',
      formFields: service.formFields,
      requiredDocumentIds: service.requiredDocumentIds,
      eligibilityConditions: [
        'Active status in Council',
        'CME credit compliance',
        'Valid identity proof',
      ],
      cmeRequirements: '30 Credits required over 5 years.',
    );
  }

  Future<CMEProgress> getCMEProgress() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return CMEProgress(
      totalCredits: 18.5,
      requiredCredits: 30.0,
      entries: [
        CMEEntry(
          id: 'cme_1',
          title: 'Advanced Cardiac Life Support',
          credits: 8.0,
          date: DateTime.now().subtract(const Duration(days: 120)),
          certificateUrl: 'https://example.com/c1.pdf',
          status: DocumentStatus.verified,
        ),
        CMEEntry(
          id: 'cme_2',
          title: 'Ethics in Clinical Research',
          credits: 5.5,
          date: DateTime.now().subtract(const Duration(days: 45)),
          certificateUrl: 'https://example.com/c2.pdf',
          status: DocumentStatus.verified,
        ),
        CMEEntry(
          id: 'cme_3',
          title: 'Telemedicine Best Practices',
          credits: 5.0,
          date: DateTime.now().subtract(const Duration(days: 10)),
          certificateUrl: 'https://example.com/c3.pdf',
          status: DocumentStatus.pending,
        ),
      ],
    );
  }

  Future<List<LicenseDocument>> getDocuments() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _documents;
  }
}
