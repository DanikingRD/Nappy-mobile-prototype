import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/providers/firebase_providers.dart';

final storageRepositoryProvider = Provider((ref) {
  return FirebaseStorageRepository(
    storage: ref.read(storageProvider),
  );
});

class FirebaseStorageRepository {
  final FirebaseStorage _storage;
  const FirebaseStorageRepository({
    required FirebaseStorage storage,
  }) : _storage = storage;

  Future<String> storeFile(String ref, File file) async {
    final UploadTask task = _storage.ref().child(ref).putFile(file);
    final TaskSnapshot snapshot = await task;
    final String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
