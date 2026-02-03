import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadedDocumentsNotifier extends StateNotifier<Set<String>> {
  UploadedDocumentsNotifier() : super({});

  void uploadDocument(String id) {
    state = {...state, id};
  }

  void removeDocument(String id) {
    state = state.where((element) => element != id).toSet();
  }

  bool isUploaded(String id) {
    return state.contains(id);
  }
}

final uploadedDocumentsProvider = StateNotifierProvider<UploadedDocumentsNotifier, Set<String>>((ref) {
  return UploadedDocumentsNotifier();
});
