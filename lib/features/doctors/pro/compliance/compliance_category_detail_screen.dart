import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class ComplianceCategoryDetailScreen extends StatefulWidget {
  final String categoryName;

  const ComplianceCategoryDetailScreen({super.key, required this.categoryName});

  @override
  State<ComplianceCategoryDetailScreen> createState() => _ComplianceCategoryDetailScreenState();
}

class _ComplianceCategoryDetailScreenState extends State<ComplianceCategoryDetailScreen> {
  // Reminder State
  final Set<int> _reminderDays = {60, 30, 7};
  bool _remindersEnabled = true;

  // Form State
  late TextEditingController _licenseNumberController;
  late TextEditingController _nameController;
  late TextEditingController _councilOrCategoryController;
  late TextEditingController _issueDateController;
  late TextEditingController _expiryDateController;
  late TextEditingController _renewalCycleController;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    if (widget.categoryName == 'Practice License') {
      _licenseNumberController = TextEditingController(text: 'PR-7782-Y');
      _nameController = TextEditingController(text: 'Dr. Sarah Morgan');
      _councilOrCategoryController = TextEditingController(text: 'Clinical Establishment'); // Category
      _issueDateController = TextEditingController(text: 'Jan 10, 2021');
      _expiryDateController = TextEditingController(text: 'Jan 10, 2026');
      _renewalCycleController = TextEditingController(text: '5 Years');
    } else {
      // Default / Medical License
      _licenseNumberController = TextEditingController(text: 'MD-9283-X');
      _nameController = TextEditingController(text: 'Dr. Sarah Morgan');
      _councilOrCategoryController = TextEditingController(text: 'California Medical Board');
      _issueDateController = TextEditingController(text: 'Oct 24, 2021');
      _expiryDateController = TextEditingController(text: 'Oct 24, 2026');
      _renewalCycleController = TextEditingController(text: '5 Years');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mock status logic
    final bool isExpiringSoon = false;
    final bool isExpired = false;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCompactStatusCard(isExpiringSoon, isExpired),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Document Vault', Icons.folder_shared_outlined),
                  const SizedBox(height: 12),
                  _buildDocumentVault(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('License Information', Icons.info_outline_rounded),
                  const SizedBox(height: 12),
                  _buildLicenseInfoForm(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Reminder Settings', Icons.notifications_active_outlined),
                  const SizedBox(height: 12),
                  _buildReminderEngine(),
                  const SizedBox(height: 24),
                  _buildSectionHeader('History & Timeline', Icons.history_rounded),
                  const SizedBox(height: 12),
                  _buildTimeline(),
                  const SizedBox(height: 32),
                  _buildFooterActions(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60,
      pinned: true,
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        widget.categoryName,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert_rounded, color: AppColors.textPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCompactStatusCard(bool isExpiringSoon, bool isExpired) {
    // Logic for colors/text
    final statusText = isExpired ? 'Expired' : (isExpiringSoon ? 'Expiring Soon' : 'Active');
    final statusColor = isExpired ? Colors.redAccent : (isExpiringSoon ? Colors.orange : Colors.white);
    final daysLeft = isExpired ? '0 Days' : '642 Days';
    
    // For Practice License, maybe different dates, but using controller text
    final expiryDate = _expiryDateController.text;

    return FadeInDown(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0E6EFF), Color(0xFF00C2A8)], // Medical Blue to Teal
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                         const Text(
                          'Status',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      daysLeft,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                    ),
                     const SizedBox(height: 2),
                     Text(
                      'Expires $expiryDate',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildDocumentVault() {
    List<Widget> sections = [];

    if (widget.categoryName == 'Clinic License') {
      sections = [
        _buildSubSectionTitle('Core Documents'),
        _buildVaultItem('Current License Copy', 'License.pdf', true),
        _buildVaultItem('Application Form (Form A)', 'FormA.pdf', true),
        _buildVaultItem('Owner ID Proof', 'Owner_ID.jpg', true, icon: Icons.person),
        _buildVaultItem('Clinic Address Proof', 'Rent_Agreement.pdf', true),
        _buildVaultItem('HFR ID', 'HFR.pdf', true),
        _buildVaultItem('HPR IDs (Doctors)', 'Active', true), // Maybe a list or summary
        _buildVaultItem('Staff Qual. Certs', 'Uploaded (4)', true),
        _buildVaultItem('Staff Council Reg.', 'Uploaded (4)', true),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Compliance Attachments'),
        _buildVaultItem('BMW Agreement', 'BMW.pdf', true),
        _buildVaultItem('Fire NOC', 'Fire_NOC.pdf', true),
        _buildVaultItem('Pollution Control NOC', 'Pending', false),
        _buildVaultItem('Premises Layout Map', 'Map.jpg', true, icon: Icons.map),
        _buildVaultItem('Tax Receipts', 'Tax_2024.pdf', true),
        _buildVaultItem('Electricity/Water Bill', 'Bill.pdf', true),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Payments'),
        _buildVaultItem('Fee Payment Receipt', 'Receipt.pdf', true, icon: Icons.receipt),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    } 

    if (widget.categoryName == 'Hospital License') {
      sections = [
        _buildSubSectionTitle('Core Documents'),
        _buildVaultItem('Hospital License Copy', 'License_Prev.pdf', true),
        _buildVaultItem('Renewal App (Form A/B)', 'Form_B_Signed.pdf', true),
        _buildVaultItem('Renewal Fee Receipt', 'Challan_8392.pdf', true, icon: Icons.receipt),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Identity & Ownership'),
        _buildVaultItem('Director/Partner ID', 'Director_PAN.jpg', true, icon: Icons.person),
        _buildVaultItem('Establishment Address', 'Deed_Reg.pdf', true),
        _buildVaultItem('Entity Proof (MoA/Deed)', 'MoA_Hospital.pdf', true),
        
        const SizedBox(height: 16),
        _buildSubSectionTitle('Facility Compliance'),
        _buildVaultItem('Fire Dept NOC', 'Fire_NOC_2024.pdf', true, icon: Icons.local_fire_department_rounded),
        _buildVaultItem('Pollution Control NOC', 'PCB_Consent.pdf', true),
        _buildVaultItem('Bio-Medical Waste Auth', 'BMW_Agree.pdf', true),
        _buildVaultItem('Property Tax Receipt', 'Tax_Receipt.pdf', true),
        _buildVaultItem('Building Plan Approval', 'Map_Plan.pdf', true, icon: Icons.map),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Staff & Clinical'),
        _buildVaultItem('Staff Qual. Certs', 'Med_Staff_Docs.zip', true),
        _buildVaultItem('Staff Council Reg.', 'Council_Regs.pdf', true),
        _buildVaultItem('Staff Work Orders', 'Pending', false),
        _buildVaultItem('HFR ID', 'HFR_Certificate.pdf', true),
        _buildVaultItem('HPR IDs (Doctors)', 'Linked (12)', true),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Operational (Optional)'),
        _buildVaultItem('Emergency Prep Plan', 'Action_Plan.pdf', true, isOptional: true),
        _buildVaultItem('Waste Mgmt Plan', 'Pending', false, isOptional: true),
        _buildVaultItem('Medical Equipment List', 'Eq_List.xlsx', true, isOptional: true),
        _buildVaultItem('Drug License', 'Pharmacy_Lic.pdf', true, isOptional: true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Speciality License') {
      sections = [
        _buildSubSectionTitle('Core Documents'),
        _buildVaultItem('Existing License Copy', 'Spe_Lic.pdf', true),
        _buildVaultItem('Renewal Application', 'Pending', false),
        _buildVaultItem('Fee Receipt', 'Fee.pdf', true, icon: Icons.receipt),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Eligibility & Credentials'),
        _buildVaultItem('Specialty Degree/Fellowship', 'Fellowship.pdf', true, icon: Icons.school),
        _buildVaultItem('Experience Certificates', 'Exp_Docs.pdf', true),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Compliance'),
        _buildVaultItem('Medical Council Reg', 'Council_Reg.pdf', true),
        _buildVaultItem('CME Credits', 'CME_Sum.pdf', true),
        _buildVaultItem('KYC Documents', 'PAN_Aadhaar.pdf', true, icon: Icons.person),
        _buildVaultItem('Address Proof', 'Util_Bill.pdf', true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Medical Indemnity') {
      sections = [
        _buildSubSectionTitle('Policy Documents'),
        _buildVaultItem('Existing Policy Copy', 'Policy_2025.pdf', true, icon: Icons.security),
        _buildVaultItem('Renewal Proposal Form', 'Prop_Form.pdf', true),
        _buildVaultItem('Payment Receipt', 'Premium_Rcpt.pdf', true, icon: Icons.receipt),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Credentials'),
        _buildVaultItem('Medical Council Reg', 'Council_Reg.pdf', true),
        _buildVaultItem('Specialty Details', 'Spe_Info.pdf', true),
        _buildVaultItem('KYC Documents', 'KYC_Bundle.pdf', true, icon: Icons.person),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Additional'),
        _buildVaultItem('Claims History', 'No Claims', true, isOptional: true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'CME Credits') {
       sections = [
        _buildSubSectionTitle('Primary Proof'),
        _buildVaultItem('CME Certificates', 'CME_Certs.zip', true, icon: Icons.card_membership),
        _buildVaultItem('CME Transcript Summary', 'Transcript.pdf', true),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Compliance'),
        _buildVaultItem('Medical Council App', 'App_Form.pdf', true),
        _buildVaultItem('Renewal Fee Receipt', 'Fee_Ack.pdf', true, icon: Icons.receipt),
        _buildVaultItem('KYC Documents', 'KYC.pdf', true),
        _buildVaultItem('Council Registration', 'Reg_Cert.pdf', true),
        _buildVaultItem('Photo ID', 'ID_Card.jpg', true, icon: Icons.person),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'E-Prescription') {
       sections = [
        _buildSubSectionTitle('Drug License'),
        _buildVaultItem('Existing Drug License', 'DL_20.pdf', true),
        _buildVaultItem('Renewal App (Form 19)', 'Form_19.pdf', true),
        _buildVaultItem('Fee Receipt', 'Challan.pdf', true, icon: Icons.receipt),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Pharmacist Details'),
        _buildVaultItem('Registration Cert', 'Pharma_Reg.pdf', true),
        _buildVaultItem('Renewal Cert', 'Pharma_Renew.pdf', true),
        _buildVaultItem('Affidavit', 'Affidavit.pdf', true),
        _buildVaultItem('Appointment Order', 'Appt_Order.pdf', true),
        _buildVaultItem('Photo + Biodata', 'Profile.pdf', true, icon: Icons.person),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Premises'),
        _buildVaultItem('Ownership/Rent Agree', 'Rent.pdf', true),
        _buildVaultItem('Property Tax Receipt', 'Tax.pdf', true),
        _buildVaultItem('Site Plan/Blueprint', 'Plan.pdf', true, icon: Icons.map),
        _buildVaultItem('Partnership/MoA', 'Deed.pdf', true),
        _buildVaultItem('KYC (Partner/Director)', 'KYC_Entity.pdf', true),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Compliance'),
        _buildVaultItem('Cold Storage Proof', 'Fridge_Inv.pdf', true),
        _buildVaultItem('Non-Conviction Aff.', 'Aff_Clean.pdf', true),
        _buildVaultItem('BMW Affidavit', 'BMW_Decl.pdf', true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Fire NOC') {
      sections = [
        _buildSubSectionTitle('NOC Documents'),
        _buildVaultItem('Existing Fire NOC', 'Fire_NOC_2024.pdf', true, icon: Icons.local_fire_department_rounded),
        _buildVaultItem('Renewal Application', 'Pending', false),
        _buildVaultItem('Fee Payment Receipt', 'Receipt.pdf', true, icon: Icons.receipt),
        
        const SizedBox(height: 16),
        _buildSubSectionTitle('Facility Details'),
        _buildVaultItem('Building Plan/Layout', 'Map_Approved.pdf', true, icon: Icons.map),
        _buildVaultItem('Fire Safety Certificate', 'Safety_Cert.pdf', true),
        _buildVaultItem('Equipment List', 'Extinguishers_List.xlsx', true),
        _buildVaultItem('Maintenance Register', 'AMC_Log.pdf', true, isOptional: true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Bio Medical Waste') {
      sections = [
        _buildSubSectionTitle('Authorization'),
        _buildVaultItem('BMW Authorization', 'BMW_Auth.pdf', true, icon: Icons.delete_outline_rounded),
        _buildVaultItem('Renewal Application', 'App_Form.pdf', true),
        _buildVaultItem('Fee Receipt', 'Fee.pdf', true, icon: Icons.receipt),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Disposal Agreement'),
        _buildVaultItem('Agency Agreement', 'Agency_Contract.pdf', true),
        _buildVaultItem('Collection Log', 'Daily_Log_May.pdf', true, isOptional: true),
        _buildVaultItem('Annual Report', 'Report_2024.pdf', true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Pollution Consent') {
      sections = [
        _buildSubSectionTitle('Consent Orders'),
        _buildVaultItem('Consent to Operate (CTO)', 'CTO_Order.pdf', true, icon: Icons.eco_outlined),
        _buildVaultItem('Renewal Application', 'Pending', false),
        _buildVaultItem('Fee Receipt', 'Challan.pdf', true, icon: Icons.receipt),

        const SizedBox(height: 16),
        _buildSubSectionTitle('Compliance Data'),
        _buildVaultItem('Compliance Report', 'Report.pdf', true),
        _buildVaultItem('Water/Air Test Reports', 'Lab_Results.pdf', true, isOptional: true),
        _buildVaultItem('Site Plan', 'Site_Map.pdf', true, icon: Icons.map),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    // --- HOSPITAL / CLINIC SPECIFIC CATEGORIES ---

    if (widget.categoryName == 'Hospital Registration') {
      sections = [
        _buildSubSectionTitle('Registration Docs'),
        _buildVaultItem('Registration Certificate', 'Reg_Cert.pdf', true, icon: Icons.business_rounded),
        _buildVaultItem('MoA / Deed', 'MoA.pdf', true),
        _buildVaultItem('Renewal Application', 'App.pdf', true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }
    
    if (widget.categoryName == 'Trade License') {
       sections = [
        _buildSubSectionTitle('Municipal License'),
        _buildVaultItem('Trade License Copy', 'Trade_Lic.pdf', true, icon: Icons.store_mall_directory_rounded),
        _buildVaultItem('Tax Receipt', 'Tax.pdf', true, icon: Icons.receipt),
      ];
       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Clinical Establishment') {
      sections = [
         _buildSubSectionTitle('Act Registration'),
         _buildVaultItem('Establishment Cert', 'CEA_Cert.pdf', true, icon: Icons.local_hospital_rounded),
         _buildVaultItem('Staff List', 'Staff.xls', true),
         _buildVaultItem('Services List', 'Services.pdf', true),
      ];
       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Lift Certificate' || widget.categoryName == 'Generator Certificate') {
      sections = [
         _buildSubSectionTitle('Safety Certificate'),
         _buildVaultItem('Inspection Report', 'Report.pdf', true, icon: Icons.analytics_rounded),
         _buildVaultItem('Safety Certificate', 'Cert.pdf', true, icon: Icons.verified_user_rounded),
         _buildVaultItem('AMC Contract', 'AMC.pdf', true),
      ];
       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName == 'Radiology/AERB' || widget.categoryName == 'X-Ray License') {
       sections = [
         _buildSubSectionTitle('AERB Approval'),
         _buildVaultItem('License for Operation', 'ELORA_Lic.pdf', true, icon: Icons.radio_button_checked_rounded),
         _buildVaultItem('RSO Approval', 'RSO_Cert.pdf', true),
         _buildVaultItem('QA Test Report', 'QA_Report.pdf', true),
         _buildVaultItem('Personnel Monitoring', 'TLD_badges.pdf', true),
      ];
       return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName.contains('Accreditation')) {
       sections = [
         _buildSubSectionTitle('Quality Standards'),
         _buildVaultItem('Accreditation Cert', 'Cert.pdf', true, icon: Icons.star_rounded),
         _buildVaultItem('Scope of Services', 'Scope.pdf', true),
         _buildVaultItem('Assessment Report', 'Assessment.pdf', true),
         _buildVaultItem('Surveillance Audit', 'Audit.pdf', true, isOptional: true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }

    if (widget.categoryName.contains('Insurance')) {
       sections = [
         _buildSubSectionTitle('Policy Details'),
         _buildVaultItem('Policy Document', 'Policy.pdf', true, icon: Icons.security_rounded),
         _buildVaultItem('Premium Receipt', 'Receipt.pdf', true, icon: Icons.receipt),
         _buildVaultItem('Claim History', 'Claims.pdf', true, isOptional: true),
      ];
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: sections);
    }
    
    if (widget.categoryName == 'Practice License') {
       // ... (Practice License items)
       return Column(children: [
        _buildVaultItem('License Front', 'IMG_2025.jpg', true, icon: Icons.image),
        // ... (rest of practice license items)
        _buildVaultItem('License Back', 'IMG_2026.jpg', true, icon: Icons.image),
        _buildVaultItem('Identity Proof', 'Aadhaar.pdf', true),
        _buildVaultItem('Address Proof', 'Elec_Bill.pdf', true),
        _buildVaultItem('Passport Photo', 'MyPhoto.jpg', true, icon: Icons.person),
        _buildVaultItem('Age Proof', 'School_Cert.pdf', true),
        _buildVaultItem('Medical Certificate', 'Med_Fitness.pdf', false),
        _buildVaultItem('Self Declaration', 'Pending', false),
        _buildVaultItem('Previous Renewals', 'Optional', false, isOptional: true),
       ]);
    }

    // Default Medical License items
    return Column(children: [
      _buildVaultItem('Front Document', 'License_Front.pdf', true),
      _buildVaultItem('Back Document', 'License_Back.pdf', true),
      _buildVaultItem('Identity Proof', 'Passport.jpg', true),
      _buildVaultItem('Degree Certificate', 'MBBS_Degree.pdf', true),
      _buildVaultItem('Registration Certificate', 'State_Reg.pdf', true),
      _buildVaultItem('Passport Photo', 'Not Uploaded', false),
      _buildVaultItem('Address Proof', 'Optional', false, isOptional: true),
      _buildVaultItem('Support Document', 'Optional', false, isOptional: true),
    ]);
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildVaultItem(String title, String statusText, bool isUploaded, {bool isOptional = false, IconData icon = Icons.description_rounded}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.glassBorder),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isUploaded ? AppColors.primary.withOpacity(0.08) : Colors.grey.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isUploaded ? icon : Icons.cloud_upload_rounded,
              color: isUploaded ? AppColors.primary : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(
                  statusText,
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isUploaded ? AppColors.textPrimary.withOpacity(0.7) : AppColors.textSecondary,
                    fontSize: 11,
                    fontStyle: isUploaded ? FontStyle.normal : FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          if (isUploaded) ...[
             // Icons right aligned
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove_red_eye_rounded, color: AppColors.primary, size: 18),
              onPressed: () => context.push('/document-viewer', extra: title),
              tooltip: 'Preview',
            ),
            const SizedBox(width: 12),
            IconButton(
               padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary, size: 18),
              onPressed: () {}, // Replace/Delete menu
            ),
          ] else ...[
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
               decoration: BoxDecoration(
                 border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                 borderRadius: BorderRadius.circular(12),
               ),
               child: const Text('Upload', style: TextStyle(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.bold)),
             ),
          ],
        ],
      ),
    );
  }

  Widget _buildLicenseInfoForm() {
    final categoryLabel = widget.categoryName == 'Practice License' ? 'Category' : 'Medical Council Name';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          _buildTextField('License Number', _licenseNumberController),
          const SizedBox(height: 12),
          _buildTextField('Name on License', _nameController),
          const SizedBox(height: 12),
          _buildTextField(categoryLabel, _councilOrCategoryController), // Dynamic Label
           const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildTextField('Issue Date', _issueDateController, icon: Icons.calendar_today_rounded)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField('Expiry Date *', _expiryDateController, icon: Icons.event_busy_rounded, isMandatory: true)),
            ],
          ),
          const SizedBox(height: 12),
          _buildTextField('Renewal Cycle', _renewalCycleController),
          const SizedBox(height: 12),
          _buildTextField('Notes', _notesController, maxLines: 3, hint: 'Add personal notes...'),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {IconData? icon, int maxLines = 1, String? hint, bool isMandatory = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isMandatory ? Colors.redAccent : AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 13, color: AppColors.textHint),
            suffixIcon: icon != null ? Icon(icon, size: 16, color: AppColors.textSecondary) : null,
            filled: true,
            fillColor: AppColors.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildReminderEngine() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.notifications_active_rounded, color: AppColors.primary, size: 16),
                  ),
                  const SizedBox(width: 10),
                  const Text('Smart Alerts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              Switch.adaptive(
                value: _remindersEnabled,
                activeColor: AppColors.primary,
                onChanged: (val) {
                  setState(() => _remindersEnabled = val);
                },
              ),
            ],
          ),
          if (_remindersEnabled) ...[
             const SizedBox(height: 16),
             Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [90, 60, 30, 15, 7, 1, 0].map((day) {
                final isSelected = _reminderDays.contains(day);
                String label = '${day}d';
                if (day == 0) label = 'Expiry';
                
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _reminderDays.remove(day);
                      } else {
                        _reminderDays.add(day);
                      }
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          _buildTimelineItem('Initial Registration', 'Jan 10, 2016', true),
          _buildTimelineConnector(true),
          _buildTimelineItem('First Renewal', 'Jan 10, 2021', true),
          _buildTimelineConnector(false),
          _buildTimelineItem('Next Renewal', 'Jan 10, 2026', false, isLast: true),
        ],
      ),
    );
  }
  
  Widget _buildTimelineItem(String title, String date, bool isDone, {bool isLast = false}) {
     return Row(
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isDone ? Colors.green : Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(color: (isDone ? Colors.green : Colors.grey).withOpacity(0.2), blurRadius: 4),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDone ? Colors.black87 : Colors.grey)),
            Text(date, style: TextStyle(fontSize: 11, color: isDone ? AppColors.textSecondary : Colors.grey[400])),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineConnector(bool isDone) {
      return Container(
      margin: const EdgeInsets.only(left: 5, top: 4, bottom: 4),
      height: 20,
      width: 2,
      color: isDone ? Colors.green.withOpacity(0.3) : Colors.grey[200],
    );
  }

  Widget _buildFooterActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            context.push('/upload-preview', extra: 'New Renewal Certificate');
          },
          icon: const Icon(Icons.upload_file_rounded, size: 20),
          label: const Text('Upload New Certificate'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            shadowColor: AppColors.primary.withOpacity(0.3),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved locally.')));
                },
                icon: const Icon(Icons.save_outlined, size: 18),
                label: const Text('Save'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  foregroundColor: AppColors.textPrimary,
                  side: BorderSide(color: AppColors.glassBorder),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ),
             const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exporting...')));
                },
                icon: const Icon(Icons.share_rounded, size: 18),
                label: const Text('Share Vault'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
