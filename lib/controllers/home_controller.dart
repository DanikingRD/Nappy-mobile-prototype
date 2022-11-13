import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/controllers/auth_controller.dart';
import 'package:nappy_mobile/controllers/user_model_controller.dart';
import 'package:nappy_mobile/providers/firebase_providers.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/widgets/loading_dialog.dart';

final homeControllerProvider = StateNotifierProvider<HomeController, Home>((ref) {
  return HomeController(
    userModelController: ref.read(userModelController.notifier),
    ref: ref,
  );
});

class Home {
  final int activePage;
  const Home({
    required this.activePage,
  });

  Home copyWith({
    int? activePage,
  }) {
    return Home(
      activePage: activePage ?? this.activePage,
    );
  }
}

class HomeController extends StateNotifier<Home> {
  final UserModelController userModelController;
  final Ref ref;

  HomeController({
    required this.userModelController,
    required this.ref,
  }) : super(
          const Home(activePage: 0),
        );
  /*
   * Update the active card of the PageView
   */
  void onPageChanged(int index) {
    state = state.copyWith(activePage: index);
  }

  Future<void> deleteCard({
    required String cardId,
    required BuildContext context,
  }) async {
    final nav = Navigator.of(context);
    showDialog(context: context, builder: ((_) => const LoadingDialog()));
    await Future.delayed(const Duration(milliseconds: 200));
    final response = await userModelController.deleteCard(
      userId: ref.read(authProvider).currentUser!.uid,
      cardId: cardId,
      context: context,
    );
    nav.pop();
    response.match(() {}, () => showSnackBar(context, "Your card was deleted successfully!"));
  }
}
