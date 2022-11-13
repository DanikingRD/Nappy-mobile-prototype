import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nappy_mobile/repositories/image_upload_repository.dart';
import 'package:nappy_mobile/utils.dart';

final imageUploadControllerProvider = Provider((ref) {
  return ImageUploadController(
    repository: ref.read(imageUploadRepository),
  );
});

class ImageUploadController {
  final ImageUploadRepository _repository;
  const ImageUploadController({
    required ImageUploadRepository repository,
  }) : _repository = repository;

  Future<String?> uploadImage({
    required BuildContext context,
    required String namespace,
    required String uid,
    required File image,
  }) async {
    final response = await _repository.uploadImage(
      namespace: namespace,
      uid: uid,
      image: image,
    );
    String? imageUrl;
    response.fold((String error) => showSnackBar(context, error), (url) => imageUrl = url);
    return imageUrl;
  }

  Future<File?> pickImage(BuildContext context) async {
    File? file;
    final imgPickerResponse = await _repository.pickImageFrom(context, ImageSource.gallery);
    imgPickerResponse.fold((l) {
      // Operation was canceled or something went wrong
      file = null;
      showSnackBar(context, l);
    }, (imagePicked) {
      file = imagePicked;
    });
    if (file != null) {
      final croppedImgResponse = await _repository.cropImage(file!);
      croppedImgResponse.fold((l) {
        // Operation was canceled or something went wrong
        file = null;
        showSnackBar(context, l);
      }, (imageCropped) {
        file = File(imageCropped.path);
        showSnackBar(context, "Image picked!");
      });
    }

    return file;
  }
}
