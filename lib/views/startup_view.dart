import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/controllers/auth_controller.dart';
import 'package:nappy_mobile/controllers/user_model_controller.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/error_view.dart';
import 'package:nappy_mobile/views/home/home_view.dart';
import 'package:nappy_mobile/views/loading_view.dart';
import 'package:nappy_mobile/views/login_view.dart';

final userInitProvider = FutureProvider.family<Option<UserModel>, BuildContext>((ref, ctx) async {
  final snack = ScaffoldMessenger.of(ctx);
  Option<UserModel> output = await ref.watch(userModelController.notifier).tryReadUserModel(ctx);
  return output.match(() {
    Future(() => showSnackBarFrom(snack, "User not found, please log in"));
    return Option.none();
  }, (user) {
    ref.read(userModelController.notifier).syncState(user);
    return Option.of(user);
  });
});

class StartUpView extends ConsumerStatefulWidget {
  const StartUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StartUpViewState();
}

class _StartUpViewState extends ConsumerState<StartUpView> {
  @override
  Widget build(BuildContext context) {
    final AsyncValue<Option<User>> authValueNotifier = ref.watch(authStateChangesProvider);
    return authValueNotifier.when(
      data: (optionalUser) => optionalUser.match(
        () => const LoginView(),
        (user) {
          final AsyncValue<Option<UserModel>> initUser = ref.watch(userInitProvider(context));
          return initUser.when(
            data: (maybeUserModel) => maybeUserModel.match(
              () => const LoginView(),
              (userModel) => const HomeView(),
            ),
            error: ((error, stackTrace) => ErrorView(errorMessage: error.toString())),
            loading: () => const LoadingView(),
          );
        },
      ),
      error: (error, stackTrace) => ErrorView(
        errorMessage: error.toString(),
      ),
      loading: () => const LoadingView(),
    );
  }
}
