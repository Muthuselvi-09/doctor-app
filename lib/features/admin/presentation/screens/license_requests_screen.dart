import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';
import '../providers/admin_providers.dart';
import '../../domain/models/admin_models.dart';

class LicenseRequestsScreen extends ConsumerStatefulWidget {
  const LicenseRequestsScreen({super.key});

  @override
  ConsumerState<LicenseRequestsScreen> createState() => _LicenseRequestsScreenState();
}

class _LicenseRequestsScreenState extends ConsumerState<LicenseRequestsScreen> {
  ApplicationStatus? _statusFilter;
  ApplicationType? _typeFilter;

  @override
  Widget build(BuildContext context) {
    final allAppsAsync = ref.watch(allApplicationsProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: RevivalColors.navyBlue),
        title: Text(
          'License Requests',
          style: GoogleFonts.outfit(
            color: RevivalColors.deepNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: RevivalColors.navyBlue),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: allAppsAsync.when(
        data: (apps) {
          // Apply filters
          var filteredApps = apps;
          if (_statusFilter != null) {
            filteredApps = filteredApps.where((a) => a.status == _statusFilter).toList();
          }
          if (_typeFilter != null) {
            filteredApps = filteredApps.where((a) => a.type == _typeFilter).toList();
          }

          if (filteredApps.isEmpty) {
            return Center(
              child: Text(
                'No applications found',
                style: GoogleFonts.outfit(color: RevivalColors.darkGrey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredApps.length,
            itemBuilder: (context, index) {
              final app = filteredApps[index];
              return _ApplicationCard(app: app);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Applications',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: RevivalColors.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Status', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ApplicationStatus.values.map((status) {
                      final isSelected = _statusFilter == status;
                      return ChoiceChip(
                        label: Text(status.toString().split('.').last),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _statusFilter = selected ? status : null;
                          });
                          this.setState(() {}); // Update parent state
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text('Type', style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                   const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      spacing: 8,
                      children: ApplicationType.values.map((type) {
                        final isSelected = _typeFilter == type;
                        return ChoiceChip(
                          label: Text(type.toString().split('.').last),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              _typeFilter = selected ? type : null;
                            });
                             this.setState(() {}); // Update parent state
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RevivalColors.navyBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ApplicationCard extends StatelessWidget {
  final LicenseApplication app;

  const _ApplicationCard({required this.app});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/admin-review', extra: app.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: RevivalColors.navyBlue.withOpacity(0.1),
                      child: Icon(
                        _getIconForType(app.userType),
                        color: RevivalColors.navyBlue,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          app.userName,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: RevivalColors.deepNavy,
                          ),
                        ),
                        Text(
                          app.id,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: RevivalColors.darkGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: app.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    app.statusLabel,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: app.statusColor,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoItem(label: 'License', value: app.licenseNumber),
                _InfoItem(label: 'Date', value: '${app.submissionDate.day}/${app.submissionDate.month}/${app.submissionDate.year}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  IconData _getIconForType(String type) {
    if (type.toLowerCase().contains('doctor')) return Icons.person;
    if (type.toLowerCase().contains('hospital')) return Icons.local_hospital;
    if (type.toLowerCase().contains('pharmacy')) return Icons.local_pharmacy;
    return Icons.business;
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;
  
  const _InfoItem({required this.label, required this.value});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 12,
            color: RevivalColors.darkGrey,
          ),
        ),
         Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: RevivalColors.deepNavy,
          ),
        ),
      ],
    );
  }
}
