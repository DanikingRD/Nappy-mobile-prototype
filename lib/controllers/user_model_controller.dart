import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/models/card.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/providers/firebase_providers.dart';
import 'package:nappy_mobile/repositories/user_model_repository.dart';
import 'package:nappy_mobile/utils.dart';

final userModelController = StateNotifierProvider<UserModelController, Option<UserModel>>((ref) {
  return UserModelController(
    respository: ref.read(userModelRepository),
    ref: ref,
  );
});

class UserModelController extends StateNotifier<Option<UserModel>> {
  final UserModelRespository _repository;
  final Ref _ref;
  UserModelController({
    required UserModelRespository respository,
    required Ref ref,
  })  : _repository = respository,
        _ref = ref,
        super(Option.none());

  /*
   * Used for updating the state of the UserModel 
   */
  void syncState(UserModel user) {
    state = Some(user);
  }

  Future<Option<UserModel>> tryReadUserModel(BuildContext context) async {
    final String id = _ref.read(authProvider).currentUser!.uid;
    final response = await _repository.readUserModel(id);
    return response.fold(
      (error) {
        showSnackBar(context, error);
        return Option.none();
      },
      (data) => Some(data),
    );
  }

  Future<bool> createModel({
    required UserModel model,
    required BuildContext context,
  }) async {
    return state.match(() => false, (previousState) async {
      final response = await _repository.createModel(model: model);
      return response.fold(
        (error) {
          showSnackBar(context, error);
          return false;
        },
        (_) => true,
      );
    });
  }

  Future<bool> mergeWithNewCard({
    required String userId,
    required CardModel newCard,
    required BuildContext context,
  }) async {
    return state.match(
      () => false,
      (previousState) async {
        final UserModel mergedData = previousState.copyWith(
          // Since our state is immutable, we are not allowed to do `state.add(card)`.
          // Instead, we should create a new UserModel which contains the previous
          // cards and the new one.
          // Using Dart's spread operator here is helpful!
          cards: [...previousState.cards, newCard],
        );
        final mergeResponse = await _repository.mergeModel(
          uid: userId,
          toMerge: mergedData,
        );
        return mergeResponse.match(
          (error) {
            showSnackBar(context, error);
            return false;
          },
          (_) {
            syncState(mergedData);
            return true;
          },
        );
      },
    );
  }

  Future<bool> deleteCard({
    required String userId,
    required String cardId,
    required BuildContext context,
  }) async {
    return state.match(
      () => false,
      (previousState) async {
        final UserModel mergedData = previousState.copyWith(
          // Our state is immutable. So we're making a new list instead of
          // changing the existing list.
          cards: [
            for (CardModel card in previousState.cards)
              if (card.cardId != cardId) card,
          ],
        );
        final mergeResponse = await _repository.mergeModel(
          uid: userId,
          toMerge: mergedData,
        );
        return mergeResponse.match(
          (error) {
            showSnackBar(context, error);
            return false;
          },
          (_) {
            syncState(mergedData);
            return true;
          },
        );
      },
    );
  }
}
