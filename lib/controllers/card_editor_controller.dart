import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/controllers/image_upload_controller.dart';
import 'package:nappy_mobile/controllers/user_model_controller.dart';
import 'package:nappy_mobile/models/badge_list_tile.dart';
import 'package:nappy_mobile/models/card.dart';
import 'package:nappy_mobile/models/card_editor.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utilities/firebase_constants.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';
import 'package:uuid/uuid.dart';

final cardEditorControllerProvider = StateNotifierProvider.autoDispose<CardEditorController, CardEditor>((ref) {
  return CardEditorController(
    imageUploadController: ref.read(imageUploadControllerProvider),
    ref: ref,
  );
});

class CardEditorController extends StateNotifier<CardEditor> {
  final ImageUploadController _imageUploadController;
  final Ref _ref;
  CardEditorController({
    required ImageUploadController imageUploadController,
    required Ref ref,
  })  : _imageUploadController = imageUploadController,
        _ref = ref,
        super(
          CardEditor(
            cardTitleField: CardEditorField("Set a card title (e.g Work or Personal)"),
            fields: [
              CardEditorField("First Name"),
              CardEditorField("Last Name"),
              CardEditorField("Job Title"),
              CardEditorField("Company Name"),
            ],
            activeColor: kPrimaryColor,
            badgeModels: [BadgeListTileModel(title: "Email", subtitle: "Subtitle", icon: Icons.dangerous)],
          ),
        );

  void selectBackground(BuildContext context) async {
    final navigator = Navigator.of(context);

    final file = await _imageUploadController.pickImage(context);
    // No rebuilds if the image data was the same as before
    if (file != state.backgroundImage) {
      state = state.copyWith(
        backgroundImage: file,
      );
    }
    navigator.pop();
  }

  void removeBackground(BuildContext context) {
    state = CardEditor(
        cardTitleField: state.cardTitleField,
        fields: state.fields,
        avatarImage: state.avatarImage,
        backgroundImage: null,
        activeColor: state.activeColor,
        badgeModels: state.badgeModels);
    Navigator.pop(context);
    showSnackBar(context, "Image removed!");
  }

  void selectAvatar(BuildContext context) async {
    final navigator = Navigator.of(context);
    final file = await _imageUploadController.pickImage(context);
    // No rebuilds if the image data was the same as before
    if (file != state.avatarImage) {
      state = state.copyWith(
        avatarImage: file,
      );
    }
    navigator.pop();
  }

  void setActiveColor(Color color) {
    state = state.copyWith(activeColor: color);
  }

  void removeAvatar(BuildContext context) {
    state = CardEditor(
      cardTitleField: state.cardTitleField,
      fields: state.fields,
      avatarImage: null,
      backgroundImage: state.backgroundImage,
      activeColor: state.activeColor,
      badgeModels: state.badgeModels,
    );
    Navigator.pop(context);
    showSnackBar(context, "Image removed!");
  }

  Future<String?> _getImageUrl({
    required File? image,
    required BuildContext context,
    required String namespace,
    required String imageId,
  }) async {
    if (image == null) {
      return null;
    }
    final String? url = await _imageUploadController.uploadImage(
      context: context,
      namespace: namespace,
      uid: imageId,
      image: image,
    );
    return url;
  }

  Future<bool> createCard(BuildContext context) async {
    final String cardId = const Uuid().v1();
    final Option<UserModel> user = _ref.read(userModelController);
    await Future.delayed(const Duration(milliseconds: 200));
    return user.match(
      () => false,
      (userModel) async {
        final String? newBackgroundUrl = await _getImageUrl(
          image: state.backgroundImage,
          context: context,
          namespace: FirebaseConstants.cardBackgroundNamespace,
          imageId: cardId,
        );
        final String? newAvatarUrl = await _getImageUrl(
          image: state.avatarImage,
          context: context,
          namespace: FirebaseConstants.cardAvatarNamespace,
          imageId: cardId,
        );

        final CardModel card = CardModel(
          cardId: cardId,
          title: state.cardTitleField.text,
          firstName: state.fields[0].text,
          lastName: state.fields[1].text,
          jobTitle: state.fields[2].text,
          company: state.fields[3].text,
          background: newBackgroundUrl ?? FirebaseConstants.defaultBackgroundURL,
          avatar: newAvatarUrl ?? FirebaseConstants.defaultAvatarURL,
          color: state.activeColor.value,
        );
        final response = await _ref.read(userModelController.notifier).mergeWithNewCard(
              context: context,
              userId: userModel.uid,
              newCard: card,
            );
        return response.match(
          () => false,
          () {
            showSnackBar(context, "Your card was created successfully!");
            return true;
          },
        );
      },
    );
  }
}
