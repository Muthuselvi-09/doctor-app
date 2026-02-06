import 'package:flutter/material.dart';
import '../domain/models/pharmacy_license_config.dart';

class PharmacyLicenseDummyData {
  static const List<PharmacyLicenseConfig> allLicenses = [
    // 1. Drug License Renewal
    PharmacyLicenseConfig(
      id: 'drug_license',
      name: 'Drug License Renewal',
      description: 'Renew your retail/wholesale drug license',
      icon: Icons.medication,
      requiredDocuments: [
        'Form 19 / Form 19A',
        'Covering Letter (ADDC)',
        'Court Fee Stamp (₹2)',
        'Existing Drug License Copy',
        'Premises Ownership / Rental Proof',
        'Property Tax Receipt',
        'Premises Blueprint (Signed)',
        'Partnership Deed / MOA / AOA',
        'Pharmacist Registration Certificate (TNPC)',
        'Pharmacist Affidavit (₹20 Stamp)',
        'Pharmacist Bio-data & Photo',
        'Applicant ID & Address Proof',
      ],
    ),

    // 2. Pharmacy Registration Renewal
    PharmacyLicenseConfig(
      id: 'pharmacy_reg',
      name: 'Pharmacy Registration Renewal',
      description: 'Renew pharmacy council registration',
      icon: Icons.assignment_turned_in,
      requiredDocuments: [
        'Form 19 Application',
        'Covering Letter with Court Fee Stamp',
        'Original Pharmacy License',
        'Premises Ownership / Lease Proof',
        'Premises Blueprint',
        'Refrigerator / AC Purchase Bills',
        'Pharmacist Affidavit',
        'Pharmacist Appointment Letter',
        'Pharmacist Photo & Signature',
        'TN Pharmacy Council Registration Proof',
      ],
    ),

    // 3. Pharmacy Establishment Renewal
    PharmacyLicenseConfig(
      id: 'establishment',
      name: 'Pharmacy Establishment Renewal',
      description: 'Renew commercial establishment license',
      icon: Icons.store,
      requiredDocuments: [
        'Form 19 / 19A',
        'Covering Letter',
        'Court Fee Stamp',
        'Existing License Copy',
        'Declaration Form',
        'Pharmacist Registration Certificate',
        'Pharmacist Appointment Letter',
        'Pharmacist Affidavit',
        'Premises Ownership / Rental Proof',
        'Legal Tenancy Affidavit',
        'Premises Blueprint',
        'Partnership / Company Documents',
        'Refrigerator & AC Bills',
        'Applicant ID Proof',
      ],
    ),

    // 4. Pharmacy Trade License Renewal
    PharmacyLicenseConfig(
      id: 'trade_license',
      name: 'Pharmacy Trade License Renewal',
      description: 'Renew municipal trade license',
      icon: Icons.business,
      requiredDocuments: [
        'Form 19 / 19A',
        'Court Fee Stamp',
        'Covering Letter',
        'Ownership / Rental Agreement',
        'Legal Tenancy Affidavit',
        'Premises Blueprint',
        'Refrigerator / AC Bills',
        'Pharmacist Registration Certificate',
        'Pharmacist Qualification Proof',
        'Experience Certificate',
        'Pharmacist Affidavit',
        'Applicant Photo & ID Proof',
        'Non-Conviction Affidavit',
      ],
    ),

    // 5. Pharmacy Old Storage License Renewal
    PharmacyLicenseConfig(
      id: 'old_storage',
      name: 'Pharmacy Old Storage License',
      description: 'Renew old storage license',
      icon: Icons.inventory_2,
      requiredDocuments: [
        'Application Form (19 / 19A / 19C)',
        'Existing Drug License',
        'Covering Letter with Court Fee Stamp',
        'Pharmacist Registration Certificate',
        'Pharmacist Qualification Proof',
        'Pharmacist Declaration',
        'Premises Ownership / Lease Proof',
        'Premises Blueprint',
        'Storage Equipment Bills',
        'Legal Tenancy Affidavit',
        'Applicant ID Proof',
      ],
    ),

    // 6. Pharmacy Biomedical Waste Renewal
    PharmacyLicenseConfig(
      id: 'bio_waste',
      name: 'Biomedical Waste Renewal',
      description: 'Renew BMW management authorization',
      icon: Icons.delete_sweep,
      requiredDocuments: [
        'Form II Application',
        'Previous BMW Authorization',
        'CBMWTF Agreement',
        'Compliance Report',
        'BMW Quantity Records',
        'Owner Aadhaar & PAN',
        'Premises Ownership Proof',
        'Pharmacy Drug License Copy',
        'Self-Declaration (if applicable)',
      ],
    ),

    // 7. Pharmacy Fire & Safety Renewal
    PharmacyLicenseConfig(
      id: 'fire_safety',
      name: 'Fire & Safety Renewal',
      description: 'Renew fire safety NOC',
      icon: Icons.fire_extinguisher,
      requiredDocuments: [
        'Request Letter',
        'Previous Fire License / NOC',
        'Approved Building Plan',
        'Property Tax / Lease Proof',
        'Fire Safety Audit Report',
        'Fire Equipment Details',
        'Self-Certification Document',
      ],
    ),

    // 8. Pharmacy Insurance Renewal
    PharmacyLicenseConfig(
      id: 'insurance',
      name: 'Pharmacy Insurance Renewal',
      description: 'Renew general/liability insurance',
      icon: Icons.shield,
      requiredDocuments: [
        'Existing Insurance Policy Copy',
        'Renewal Application Form',
        'Covering Letter',
        'Fee Payment Receipt',
        'Court Fee Stamp',
        'Ownership / Rental Proof',
        'Legal Tenancy Affidavit',
        'Premises Blueprint',
        'Refrigerator & AC Bills',
        'Pharmacist Registration Certificate',
        'Pharmacist Qualification Proof',
        'Appointment / Release Letter',
        'Applicant & Pharmacist Photos',
        'Reconstitution Deed (if applicable)',
      ],
    ),
  ];
}
