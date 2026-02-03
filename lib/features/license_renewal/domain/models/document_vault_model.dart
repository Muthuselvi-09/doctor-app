
enum DocumentStatus {
  valid,
  expired,
  needsUpdate,
  pendingVerification,
  rejected,
}

enum ClientType {
  doctor,
  hospital,
  pharmacy,
}

class DocumentProperty {
  final String id;
  final String title;
  final String documentType;
  final String issuingAuthority;
  final DateTime uploadDate;
  final DateTime? expiryDate;
  final List<String> linkedLicenseIds;
  final DocumentStatus status;
  final String fileUrl;
  final String? version;

  DocumentProperty({
    required this.id,
    required this.title,
    required this.documentType,
    required this.issuingAuthority,
    required this.uploadDate,
    this.expiryDate,
    required this.linkedLicenseIds,
    required this.status,
    required this.fileUrl,
    this.version,
  });

  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());

  DocumentProperty copyWith({
    DocumentStatus? status,
    List<String>? linkedLicenseIds,
    String? version,
  }) {
    return DocumentProperty(
      id: id,
      title: title,
      documentType: documentType,
      issuingAuthority: issuingAuthority,
      uploadDate: uploadDate,
      expiryDate: expiryDate,
      linkedLicenseIds: linkedLicenseIds ?? this.linkedLicenseIds,
      status: status ?? this.status,
      fileUrl: fileUrl,
      version: version ?? this.version,
    );
  }
}

class LicenseRequirement {
  final String id;
  final String title;
  final List<String> mandatoryDocumentTypes;
  final List<String> conditionalDocumentTypes;
  final String authority;

  LicenseRequirement({
    required this.id,
    required this.title,
    required this.mandatoryDocumentTypes,
    this.conditionalDocumentTypes = const [],
    required this.authority,
  });
}
