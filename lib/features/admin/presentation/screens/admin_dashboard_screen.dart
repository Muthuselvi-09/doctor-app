import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doctor_app/core/theme/revival_colors.dart';
import '../providers/admin_providers.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(adminStatsProvider);
    final appsAsync = ref.watch(allApplicationsProvider);

    return Scaffold(
      backgroundColor: RevivalColors.softGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.outfit(
            color: RevivalColors.deepNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.notifications_none, color: RevivalColors.deepNavy),
          ),
          const SizedBox(width: 8),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: RevivalColors.navyBlue,
              child: Icon(Icons.person, size: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: RevivalColors.navyBlue),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.admin_panel_settings,
                    color: RevivalColors.navyBlue),
              ),
              accountName: Text('System Admin',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
              accountEmail: Text('admin@doctorrevival.com',
                  style: GoogleFonts.outfit()),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text('Overview', style: GoogleFonts.outfit()),
              onTap: () {},
              selected: true,
              selectedColor: RevivalColors.navyBlue,
            ),
            ListTile(
              leading: const Icon(Icons.people_outline),
              title: Text('Users & Doctors', style: GoogleFonts.outfit()),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.verified_user_outlined),
              title: Text('License Reviews', style: GoogleFonts.outfit()),
              trailing: statsAsync.when(
                data: (stats) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('${stats.pendingReviews}',
                      style: GoogleFonts.outfit(
                          color: Colors.white, fontSize: 12)),
                ),
                 loading: () => const SizedBox.shrink(),
                error: (_,__) => const SizedBox.shrink(),
              ),
              onTap: () => context.go('/admin-license-requests'),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: Text('Settings', style: GoogleFonts.outfit()),
              onTap: () {},
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title:
                  Text('Logout', style: GoogleFonts.outfit(color: Colors.red)),
              onTap: () => context.go('/role-selection'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Text(
                'Overview',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: RevivalColors.deepNavy,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Analytics Cards
            FadeInUp(
              child: statsAsync.when(
                data: (stats) => GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _AnalyticsCard(
                      title: 'Total Doctors',
                      value: stats.totalDoctors.toString(),
                      icon: Icons.medical_services,
                      color: Colors.blue,
                    ),
                    _AnalyticsCard(
                      title: 'Pending Reviews',
                      value: stats.pendingReviews.toString(),
                      icon: Icons.pending_actions,
                      color: Colors.orange,
                    ),
                    _AnalyticsCard(
                      title: 'Revenue',
                      value: '\$${stats.revenue}',
                      icon: Icons.attach_money,
                      color: Colors.green,
                    ),
                    _AnalyticsCard(
                      title: 'Issues',
                      value: stats.issues.toString(),
                      icon: Icons.warning_amber,
                      color: Colors.red,
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text('Error loading stats: $e'),
              ),
            ),

            const SizedBox(height: 32),

            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Applications',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: RevivalColors.deepNavy,
                    ),
                  ),
                  TextButton(
                      onPressed: () => context.go('/admin-license-requests'),
                      child: const Text('View All'))
                ],
              ),
            ),
            const SizedBox(height: 16),

            FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: appsAsync.when(
                data: (apps) {
                  final recentApps = apps.take(5).toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recentApps.length,
                    itemBuilder: (context, index) {
                      final app = recentApps[index];
                      return GestureDetector(
                        onTap: () => context.push('/admin-review', extra: app.id),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: RevivalColors.midGrey.withOpacity(0.5)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Colors.blue.withOpacity(0.1),
                                    child: const Text('Dr',
                                        style: TextStyle(color: Colors.blue)),
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        app.userName,
                                        style: GoogleFonts.outfit(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${app.userType} - ${app.licenseNumber}',
                                        style: GoogleFonts.outfit(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: app.statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  app.statusLabel,
                                  style: GoogleFonts.outfit(
                                    color: app.statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, s) => Text('Error loading applications: $e'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _AnalyticsCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: RevivalColors.deepNavy,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: RevivalColors.darkGrey,
            ),
          ),
        ],
      ),
    );
  }
}
