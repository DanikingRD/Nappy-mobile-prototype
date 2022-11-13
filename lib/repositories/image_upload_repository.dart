import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nappy_mobile/providers/firebase_providers.dart';
import 'package:nappy_mobile/repositories/storage_repository.dart';

final imageUploadRepository = Provider((ref) {
  return ImageUploadRepository(
      storage: ref.watch(storageProvider), firestore: ref.watch(firestoreProvider), ref: ref);
});

class ImageUploadRepository {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;
  final Ref _ref;
  const ImageUploadRepository({
    required FirebaseStorage storage,
    required FirebaseFirestore firestore,
    required Ref ref,
  })  : _storage = storage,
        _firestore = firestore,
        _ref = ref;


  Future<Either<String, String>> uploadImage({
    required String namespace,
    required String uid,
    required File image,
  }) async {
    try {
      final String url = await _ref.read(storageRepositoryProvider).storeFile(
            '$namespace/$uid',
            image,
          );
      return right(url);
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, CroppedFile>> cropImage(File image) async {
    try {
      final newImage = await ImageCropper().cropImage(sourcePath: image.path);
      if (newImage == null) {
        return left("Image crop canceled.");
      }
      return right(newImage);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, File>> pickImageFrom(BuildContext context, ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) {
        return left("No image was picked");
      }
      return right(File(pickedImage.path));
    } catch (e) {
      return left(e.toString());
    }
  }
}
