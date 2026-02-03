import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/compliance_repository.dart';
import '../../domain/models/compliance_models.dart';

final complianceRepositoryProvider = Provider((ref) => ComplianceRepository());

final licenseServicesProvider = FutureProvider<List<LicenseService>>((ref) {
  final repository = ref.watch(complianceRepositoryProvider);
  return repository.getServices();
});

final cmeProgressProvider = FutureProvider<CMEProgress>((ref) {
  final repository = ref.watch(complianceRepositoryProvider);
  return repository.getCMEProgress();
});

final complianceDocumentsProvider = FutureProvider<List<LicenseDocument>>((ref) {
  final repository = ref.watch(complianceRepositoryProvider);
  return repository.getDocuments();
});

final licenseRequirementProvider = FutureProvider.family<LicenseRequirement?, String>((ref, id) {
  final repository = ref.watch(complianceRepositoryProvider);
  return repository.getRequirement(id);
});
