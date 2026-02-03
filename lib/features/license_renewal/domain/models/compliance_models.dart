
enum LicenseStatus {
  active,
  expiring,
  expired,
  underVerification,
  appliedToAuthority,
  approvedByAuthority,
  correctionRequired,
  pendingSubmission,
}

enum DocumentStatus {
  pending,
  verified,
  rejected,
  expired,
  missing,
}

class LicenseFormField {
  final String label;
  final String hint;
  final bool isRequired;
  final String? value;

  LicenseFormField({
    required this.label,
    required this.hint,
    this.isRequired = true,
    this.value,
  });
}

class LicenseService {
  final String id;
  final String title;
  final String description;
  final String? registrationNumber;
  final String? medicalCouncil;
  final LicenseStatus status;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final List<String> requiredDocumentIds;
  final List<LicenseFormField> formFields;
  final String? certificateUrl;

  LicenseService({
    required this.id,
    required this.title,
    required this.description,
    this.registrationNumber,
    this.medicalCouncil,
    this.status = LicenseStatus.pendingSubmission,
    this.issueDate,
    this.expiryDate,
    this.requiredDocumentIds = const [],
    this.formFields = const [],
    this.certificateUrl,
  });
}

class LicenseDocument {
  final String id;
  final String name;
  final String? url;
  final DocumentStatus status;
  final DateTime? uploadDate;
  final DateTime? expiryDate;
  final String? adminRemarks;
  final bool isMandatory;
  final String category; 
  final List<String> linkedLicenseTypes;

  LicenseDocument({
    required this.id,
    required this.name,
    this.url,
    this.status = DocumentStatus.pending,
    this.uploadDate,
    this.expiryDate,
    this.adminRemarks,
    this.isMandatory = true,
    required this.category,
    this.linkedLicenseTypes = const [],
  });
}

class LicenseRequirement {
  final String licenseTypeId;
  final String introduction;
  final List<LicenseFormField> formFields;
  final List<String> requiredDocumentIds;
  final List<String> eligibilityConditions;
  final String cmeRequirements;

  LicenseRequirement({
    required this.licenseTypeId,
    required this.introduction,
    required this.formFields,
    required this.requiredDocumentIds,
    required this.eligibilityConditions,
    required this.cmeRequirements,
  });
}

class CMEProgress {
  final double totalCredits;
  final double requiredCredits;
  final List<CMEEntry> entries;

  CMEProgress({
    required this.totalCredits,
    required this.requiredCredits,
    this.entries = const [],
  });

  double get percentage => (totalCredits / requiredCredits).clamp(0.0, 1.0);
}

class CMEEntry {
  final String id;
  final String title;
  final double credits;
  final DateTime date;
  final String certificateUrl;
  final DocumentStatus status;

  CMEEntry({
    required this.id,
    required this.title,
    required this.credits,
    required this.date,
    required this.certificateUrl,
    this.status = DocumentStatus.pending,
  });
}
