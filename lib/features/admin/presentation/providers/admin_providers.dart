import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/admin_repository.dart';
import '../../domain/models/admin_models.dart';

// Stats Provider
final adminStatsProvider = FutureProvider<AdminStats>((ref) async {
  final repo = ref.watch(adminRepositoryProvider);
  return repo.getDashboardStats();
});

// All Applications Provider
final allApplicationsProvider = FutureProvider<List<LicenseApplication>>((ref) async {
   final repo = ref.watch(adminRepositoryProvider);
   return repo.getAllApplications();
});

// Filtered Applications (Example of derived state)
final pendingApplicationsProvider = Provider<AsyncValue<List<LicenseApplication>>>((ref) {
  final allApps = ref.watch(allApplicationsProvider);
  return allApps.whenData((apps) => 
    apps.where((app) => 
      app.status == ApplicationStatus.received || 
      app.status == ApplicationStatus.underVerification
    ).toList()
  );
});

// Single Application Provider (Family)
final applicationReviewProvider = FutureProvider.family<LicenseApplication?, String>((ref, id) async {
   final repo = ref.watch(adminRepositoryProvider);
   return repo.getApplicationById(id);
});

// Controller for Mutations
class AdminController extends StateNotifier<AsyncValue<void>> {
  final AdminRepository _repo;
  final Ref _ref;

  AdminController(this._repo, this._ref) : super(const AsyncValue.data(null));

  Future<void> updateApplicationStatus(String appId, ApplicationStatus status, {
    String? externalAppNum,
    DateTime? expectedDate,
    String? rejectionReason,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.updateApplicationStatus(
        appId, 
        status, 
        externalAppNum: externalAppNum,
        expectedDate: expectedDate,
        rejectionReason: rejectionReason,
      );
      // Invalidate relevant providers to refresh UI
      _ref.invalidate(allApplicationsProvider);
      _ref.invalidate(applicationReviewProvider(appId));
      _ref.invalidate(adminStatsProvider);
    });
  }

  Future<void> updateDocumentStatus(String appId, String docId, DocumentStatus status, {String? remark}) async {
    // Only set loading for this specific action if needed, or keep global
    // Here we might just want to invalidate without full screen loading blocking, 
    // but for simplicity we use the same state
     state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.updateDocumentStatus(appId, docId, status, remark: remark);
      _ref.invalidate(applicationReviewProvider(appId));
    });
  }
  
  Future<void> uploadCertificate(String appId, String path) async {
     state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repo.uploadCertificate(appId, path);
       _ref.invalidate(allApplicationsProvider);
      _ref.invalidate(applicationReviewProvider(appId));
    });
  }
}

final adminControllerProvider = StateNotifierProvider<AdminController, AsyncValue<void>>((ref) {
  return AdminController(ref.watch(adminRepositoryProvider), ref);
});
