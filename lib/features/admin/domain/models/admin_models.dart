import 'package:flutter/material.dart';

enum ApplicationStatus {
  received,
  underVerification,
  appliedExternally,
  underAuthorityReview,
  approved,
  rejected,
}

enum DocumentStatus {
  pending,
  verified,
  missing,
  rejected,
  reuploadRequired,
}

enum ApplicationType {
  medicalLicense,
  clinicRegistration,
  hospitalLicense,
  pharmacyLicense,
  fireSafety,
  pollutionControl,
}

class AdminStats {
  final int totalDoctors;
  final int pendingReviews;
  final double revenue;
  final int issues;
  final int verifiedToday;
  final int expiringAlerts;

  const AdminStats({
    required this.totalDoctors,
    required this.pendingReviews,
    required this.revenue,
    required this.issues,
    required this.verifiedToday,
    required this.expiringAlerts,
  });
}

class LicenseDocument {
  final String id;
  final String name;
  final String url; // Mock URL or path
  final DocumentStatus status;
  final String? adminRemark;
  final DateTime? uploadDate;

  LicenseDocument({
    required this.id,
    required this.name,
    required this.url,
    this.status = DocumentStatus.pending,
    this.adminRemark,
    this.uploadDate,
  });

  LicenseDocument copyWith({
    String? id,
    String? name,
    String? url,
    DocumentStatus? status,
    String? adminRemark,
    DateTime? uploadDate,
  }) {
    return LicenseDocument(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      status: status ?? this.status,
      adminRemark: adminRemark ?? this.adminRemark,
      uploadDate: uploadDate ?? this.uploadDate,
    );
  }
}

class LicenseApplication {
  final String id;
  final String userId;
  final String userName; // Doctor/Hospital Name
  final String userType; // 'Doctor', 'Hospital', etc.
  final String licenseNumber;
  final ApplicationType type;
  final ApplicationStatus status;
  final DateTime submissionDate;
  final DateTime? expectedApprovalDate;
  final List<LicenseDocument> documents;
  final String? assignedAdminId;
  final String? externalApplicationNumber; // For tracking on govt sites
  final String? rejectionReason;
  final String? certificateUrl; // If approved

  LicenseApplication({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userType,
    required this.licenseNumber,
    required this.type,
    this.status = ApplicationStatus.received,
    required this.submissionDate,
    this.expectedApprovalDate,
    required this.documents,
    this.assignedAdminId,
    this.externalApplicationNumber,
    this.rejectionReason,
    this.certificateUrl,
  });

  LicenseApplication copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userType,
    String? licenseNumber,
    ApplicationType? type,
    ApplicationStatus? status,
    DateTime? submissionDate,
    DateTime? expectedApprovalDate,
    List<LicenseDocument>? documents,
    String? assignedAdminId,
    String? externalApplicationNumber,
    String? rejectionReason,
    String? certificateUrl,
  }) {
    return LicenseApplication(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userType: userType ?? this.userType,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      type: type ?? this.type,
      status: status ?? this.status,
      submissionDate: submissionDate ?? this.submissionDate,
      expectedApprovalDate: expectedApprovalDate ?? this.expectedApprovalDate,
      documents: documents ?? this.documents,
      assignedAdminId: assignedAdminId ?? this.assignedAdminId,
      externalApplicationNumber: externalApplicationNumber ?? this.externalApplicationNumber,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      certificateUrl: certificateUrl ?? this.certificateUrl,
    );
  }

  // Helper to check if all docs are verified
  bool get areAllDocumentsVerified {
    if (documents.isEmpty) return false;
    return documents.every((doc) => doc.status == DocumentStatus.verified);
  }
  
  Color get statusColor {
     switch (status) {
      case ApplicationStatus.received:
        return Colors.blue;
      case ApplicationStatus.underVerification:
        return Colors.orange;
      case ApplicationStatus.appliedExternally:
        return Colors.purple;
      case ApplicationStatus.underAuthorityReview:
        return Colors.indigo;
      case ApplicationStatus.approved:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
    }
  }
  
  String get statusLabel {
     switch (status) {
      case ApplicationStatus.received:
        return 'Received';
      case ApplicationStatus.underVerification:
        return 'Under Verification';
      case ApplicationStatus.appliedExternally:
        return 'Applied Externally';
      case ApplicationStatus.underAuthorityReview:
        return 'Authority Review';
      case ApplicationStatus.approved:
        return 'Approved';
      case ApplicationStatus.rejected:
        return 'Rejected';
    }
  }
}
