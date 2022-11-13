import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/controllers/user_model_controller.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/auth_repository.dart';
import 'package:nappy_mobile/views/login_view.dart';

import '../utils.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.read(authRepositoryProvider),
    userModelController: ref.read(userModelController.notifier),
  );
});

final authStateChangesProvider = StreamProvider<Option<User>>((ref) {
  final authController = ref.read(authRepositoryProvider);
  return authController.authStateChanges;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final UserModelController _userModelController;
  AuthController({
    required AuthRepository authRepository,
    required UserModelController userModelController,
  })  : _authRepository = authRepository,
        _userModelController = userModelController,
        super(false); // not loading

  Future<bool> registerWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final snack = ScaffoldMessenger.of(context);

    final registrationResponse = await _authRepository.registerWithEmail(email, password);
    Option<UserCredential> maybeCredentials = Option.none();
    registrationResponse.fold(
      (l) => showSnackBarFrom(snack, l),
      (creds) {
        maybeCredentials = Some(creds);
      },
    );
    state = false;
    return maybeCredentials.match(
      () => false,
      (credentials) async {
        UserModel userModel = UserModel(
          uid: credentials.user!.uid,
          email: credentials.user!.email!,
          cards: const [],
        );
        _userModelController.syncState(userModel); // update userModel
        final response = await _userModelController.createModel(
          model: userModel,
          context: context,
        );
        return response.match(() => false, () {
          showSnackBarFrom(snack, "Welcome to Nappy!");
          return true;
        });
      },
    );
  }

  Future<bool> logIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final snack = ScaffoldMessenger.of(context);

    final logInResponse = await _authRepository.logIn(email, password);
    Option<UserCredential> maybeCredentials = Option.none();
    logInResponse.fold(
      (error) => showSnackBarFrom(snack, error),
      (user) => maybeCredentials = Some(user),
    );
    return maybeCredentials.match(
      () {
        state = false;
        return false;
      },
      (credentials) async {
        final userDataResponse = await _userModelController.tryReadUserModel(context);

        return userDataResponse.match(
          () => false,
          (userModel) {
            _userModelController.syncState(userModel); // update userModel
            showSnackBarFrom(snack, "Welcome back!");
            return true;
          },
        );
      },
    );
  }

  void signOut(BuildContext context) async {
    state = true;
    final snack = ScaffoldMessenger.of(context);
    final response = await _authRepository.signOut();
    state = false;
    response.fold((l) => showSnackBarFrom(snack, l), (_) {});
  }

  void deleteUser(BuildContext context) async {
    final snack = ScaffoldMessenger.of(context);
    final respose = await _authRepository.deleteUser();
    respose.fold(
      (error) => showSnackBarFrom(snack, error),
      (_) => Navigator.pushReplacementNamed(context, LoginView.id),
    );
  }
}
