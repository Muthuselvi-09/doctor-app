
class LicenseRequirement {
  final String id;
  final String name;
  final String introduction;
  final List<LicenseDocument> documents;
  final List<String> formFields;

  LicenseRequirement({
    required this.id,
    required this.name,
    required this.introduction,
    required this.documents,
    required this.formFields,
  });
}

class LicenseDocument {
  final String id;
  final String title;
  final String description;
  final bool isMandatory;

  LicenseDocument({
    required this.id,
    required this.title,
    required this.description,
    this.isMandatory = true,
  });
}

class LicenseRepository {
  static LicenseRequirement getRequirements(String licenseName) {
    // Normalize string to match keys loosely if needed, or use exact matches from dashboard
    if (licenseName.contains('Medical License')) return _medicalLicense;
    if (licenseName.contains('Practice License')) return _practiceLicense;
    if (licenseName.contains('Hospital License')) return _hospitalLicense;
    if (licenseName.contains('Clinic License')) return _clinicLicense;
    if (licenseName.contains('Speciality') || licenseName.contains('Specialty')) return _specialtyLicense;
    if (licenseName.contains('Indemnity') || licenseName.contains('Insurance')) return _indemnityInsurance;
    if (licenseName.contains('CME')) return _cmeCredits;
    // Pharmacy Matches
    if (licenseName.contains('Drug') || licenseName.contains('Pharmacy')) return _drugLicense;
    if (licenseName.contains('Fire')) return _fireSafety;
    if (licenseName.contains('Bio')) return _bioMedical;
    
    // Default fallback
    return _medicalLicense;
  }

  static final _medicalLicense = LicenseRequirement(
    id: 'med_renewal',
    name: 'Medical License Renewal',
    introduction: 'Renew your registration with the State Medical Council.',
    formFields: ['License Number', 'State Council', 'Registration Date', 'Qualification Year'],
    documents: [
      LicenseDocument(id: 'app_form', title: 'Completed Application Form', description: 'Signed and filled application form'),
      LicenseDocument(id: 'green_book', title: 'Medical Registration Certificate (Green Book)', description: 'Current or Expired Copy'),
      LicenseDocument(id: 'cme_certs', title: 'CME Certificates', description: 'Proof of credit hours (30 Hours)'),
      LicenseDocument(id: 'id_proof', title: 'Identity Proof', description: 'Aadhaar / Passport / Voter ID'),
      LicenseDocument(id: 'photo', title: 'Passport Size Photograph', description: 'Recent color photograph with white background'),
      LicenseDocument(id: 'address_proof', title: 'Address Proof', description: 'Utility Bill or Driving License'),
    ],
  );

  static final _practiceLicense = LicenseRequirement(
    id: 'practice_renewal',
    name: 'Doctor Practice License',
    introduction: 'Renew your certificate to practice medicine.',
    formFields: ['License Number', 'Establishment Name', 'Practice Type'],
    documents: [
      LicenseDocument(id: 'photo', title: 'Recent Color Photo', description: 'JPEG/PNG, <1MB'),
      LicenseDocument(id: 'mbbs_cert', title: 'MBBS Registration Certificate', description: 'Issued by State Council'),
      LicenseDocument(id: 'add_qual', title: 'Additional Qualification', description: 'If applicable'),
      LicenseDocument(id: 'aadhaar', title: 'Aadhaar Card', description: 'Scanned front and back'),
      LicenseDocument(id: 'prev_renew', title: 'Previous Registration', description: 'Latest renewal copy'),
      LicenseDocument(id: 'cme_certs', title: 'CME Credit Certificates', description: 'Evidence of credits'),
      LicenseDocument(id: 'req_letter', title: 'Request Letter', description: 'Addressed to Registrar'),
    ],
  );

  static final _hospitalLicense = LicenseRequirement(
    id: 'hospital_renewal',
    name: 'Hospital License Renewal',
    introduction: 'Compliance for Clinical Establishments Act.',
    formFields: ['Registration Number', 'Hospital Name', 'Bed Count', 'District'],
    documents: [
      LicenseDocument(id: 'form_b_i', title: 'Form B/I Application', description: 'Duly signed application'),
      LicenseDocument(id: 'orig_reg', title: 'Original Registration', description: 'Current certificate'),
      LicenseDocument(id: 'fire_noc', title: 'Fire Safety NOC', description: 'Updated certificate'),
      LicenseDocument(id: 'pcb_consent', title: 'Pollution Control Consent', description: 'Valid clearance'),
      LicenseDocument(id: 'bmw_agree', title: 'Bio-Medical Waste Agreement', description: 'Current contract'),
      LicenseDocument(id: 'ownersip', title: 'Ownership/Rental Proof', description: 'Deed or Agreement'),
      LicenseDocument(id: 'tax_receipt', title: 'Property Tax Receipt', description: 'Latest receipt'),
      LicenseDocument(id: 'trade_lic', title: 'Trade License', description: 'From local authority'),
      LicenseDocument(id: 'staff_cred', title: 'Staff Credentials', description: 'Medical & Nursing staff certs'),
      LicenseDocument(id: 'equip_list', title: 'Equipment List', description: 'List of medical equipment'),
      LicenseDocument(id: 'parking_aff', title: 'Parking Affidavit', description: 'Regarding parking space'),
    ],
  );

  static final _clinicLicense = LicenseRequirement(
    id: 'clinic_renewal',
    name: 'Clinic License Renewal',
    introduction: 'Renewal for small clinical establishments.',
    formFields: ['Clinic Name', 'Owner Name', 'HFR ID', 'Address'],
    documents: [
      LicenseDocument(id: 'form_1', title: 'Application Form 1', description: 'Renewal application'),
      LicenseDocument(id: 'id_own', title: 'Identity & Ownership', description: 'PAN/Aadhaar of Owner'),
      LicenseDocument(id: 'staff_qual', title: 'Staff Qualifications', description: 'Degrees & Council Regs'),
      LicenseDocument(id: 'est_proof', title: 'Establishment Proof', description: 'Trade/Rent/Tax receipt'),
      LicenseDocument(id: 'bmw_auth', title: 'Bio-Medical Waste Auth', description: 'Disposal agreement'),
      LicenseDocument(id: 'fire_noc', title: 'Fire NOC', description: 'If applicable'),
      LicenseDocument(id: 'pol_clr', title: 'Pollution Clearance', description: 'Consent to operate'),
      LicenseDocument(id: 'hfr_hpr', title: 'HFR & HPR IDs', description: 'Registry IDs'),
      LicenseDocument(id: 'fee', title: 'Fee Payment', description: 'Proof of payment'),
    ],
  );

  static final _specialtyLicense = LicenseRequirement(
    id: 'specialty_renewal',
    name: 'Specialty License Renewal',
    introduction: 'Validation for specialized medical practice.',
    formFields: ['Specialty Name', 'PG Degree info', 'Board Certification'],
    documents: [
      LicenseDocument(id: 'app_form', title: 'Application Form', description: 'Completed form'),
      LicenseDocument(id: 'cme_proof', title: 'Proof of CME', description: '30+ hours in specialty'),
      LicenseDocument(id: 'curr_lic', title: 'Current License', description: 'Existing registration'),
      LicenseDocument(id: 'photo', title: 'Photograph', description: 'Latest profile photo'),
      LicenseDocument(id: 'qual_cert', title: 'Qualification Certificates', description: 'MBBS + PG/Specialty'),
      LicenseDocument(id: 'id_proof', title: 'ID Proof', description: 'Passport/Voter ID'),
      LicenseDocument(id: 'good_stand', title: 'Good Standing Cert', description: 'From council'),
      LicenseDocument(id: 'logbook', title: 'Surgeon Logbook', description: 'Records of last 2 years', isMandatory: false),
    ],
  );

  static final _indemnityInsurance = LicenseRequirement(
    id: 'indemnity_renewal',
    name: 'Medical Indemnity Insurance',
    introduction: 'Professional liability coverage renewal.',
    formFields: ['Policy Number', 'Insurer Name', 'Sum Insured', 'Expiry Date'],
    documents: [
      LicenseDocument(id: 'prop_form', title: 'Proposal Form', description: 'Filled and signed'),
      LicenseDocument(id: 'pol_copy', title: 'Current Policy Copy', description: 'Expiring policy/card'),
      LicenseDocument(id: 'med_lic', title: 'Updated Medical License', description: 'Active practice proof'),
      LicenseDocument(id: 'staff_list', title: 'List of Qualified Staff', description: 'Nurses/Techs covered'),
      LicenseDocument(id: 'claims_hist', title: 'Claims History', description: 'Declaration of past incidents'),
      LicenseDocument(id: 'kyc', title: 'KYC Documents', description: 'ID and Address proof'),
    ],
  );

  static final _cmeCredits = LicenseRequirement(
    id: 'cme_credits',
    name: 'CME Credits',
    introduction: 'Tracking Continuing Medical Education hours.',
    formFields: ['Council Reg No', 'Cycle Start Year'],
    documents: [
      LicenseDocument(id: 'cme_certs', title: 'CME Certificates', description: 'Workshops/Conferences'),
      LicenseDocument(id: 'exp_letter', title: 'Experience Letter', description: 'Teaching faculty proof'),
      LicenseDocument(id: 'pg_course', title: 'PG Course Proof', description: 'Completion certificates'),
      LicenseDocument(id: 'sick_proof', title: 'Exemption Proof', description: 'Sickness/Disability if any', isMandatory: false),
    ],
  );

  static final _drugLicense = LicenseRequirement(
    id: 'drug_license',
    name: 'Drug License Renewal',
    introduction: 'Authorization to sell/stock drugs (Forms 20/21).',
    formFields: ['License No', 'Shop Name', 'Pharmacist Name', 'Area (Sq ft)'],
    documents: [
      LicenseDocument(id: 'forms_19', title: 'Forms 19/19A/19B', description: 'Application forms'),
      LicenseDocument(id: 'exist_lic', title: 'Existing License', description: 'Original copy'),
      LicenseDocument(id: 'id_addr', title: 'ID & Address Proof', description: 'Proprietor/Partner'),
      LicenseDocument(id: 'photo', title: 'Photos', description: 'Passport size'),
      LicenseDocument(id: 'premises', title: 'Premises Proof', description: 'Rent/Ownership + Site Plan'),
      LicenseDocument(id: 'elec_bill', title: 'Utility Bill', description: 'Electricity/Water'),
      LicenseDocument(id: 'pharm_reg', title: 'Pharmacist  Reg Cert', description: 'Pharmacy Council Reg'),
      LicenseDocument(id: 'pharm_aff', title: 'Pharmacist Affidavit', description: 'Appointment & Declaration'),
      LicenseDocument(id: 'cold_stor', title: 'Cold Storage Proof', description: 'Invoice/Refrigerator details'),
      LicenseDocument(id: 'non_conv', title: 'Non-Conviction Affidavit', description: 'Legal declaration'),
      LicenseDocument(id: 'key_lock', title: 'Schedule X Undertaking', description: 'Lock & Key declaration', isMandatory: false),
    ],
  );
  
  static final _fireSafety = LicenseRequirement(
    id: 'fire_noc',
    name: 'Fire Safety NOC',
    introduction: 'Fire Department No Objection Certificate.',
    formFields: ['Building Height', 'Area', 'Fire Extinguisher Count'],
    documents: [
      LicenseDocument(id: 'app_form', title: 'Application Form', description: 'Standard Form'),
      LicenseDocument(id: 'build_plan', title: 'Building Plan', description: 'Approved layout'),
      LicenseDocument(id: 'exist_noc', title: 'Previous NOC', description: 'If renewal'),
      LicenseDocument(id: 'maint_cert', title: 'Maintenance Cert', description: 'Fire equipment status'),
    ],
  );
  
  static final _bioMedical = LicenseRequirement(
    id: 'bmw_auth',
    name: 'Bio-Medical Waste',
    introduction: 'Authorization for handling bio-medical waste.',
    formFields: ['HCE Type', 'Bed Strength', 'Waste Category'],
    documents: [
      LicenseDocument(id: 'app_form', title: 'Form II', description: 'Application for authorization'),
      LicenseDocument(id: 'agree_copy', title: 'Service Agreement', description: 'With CBMWTF operator'),
      LicenseDocument(id: 'annual_rep', title: 'Annual Report', description: 'Previous year waste data'),
      LicenseDocument(id: 'cons_operate', title: 'Consent to Operate', description: 'From Pollution Board'),
    ],
  );
}
