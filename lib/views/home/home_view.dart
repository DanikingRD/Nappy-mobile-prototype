import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/controllers/home_controller.dart';
import 'package:nappy_mobile/controllers/user_model_controller.dart';
import 'package:nappy_mobile/models/card.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';
import 'package:nappy_mobile/views/card_presentation/card_presentation.dart';
import 'package:nappy_mobile/views/home/widgets/delete_card_dialog.dart';
import 'package:nappy_mobile/views/home/widgets/get_started.dart';
import 'package:nappy_mobile/views/card_editor/widgets/app_drawer.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/views/home/widgets/page_indicator.dart';
import 'package:nappy_mobile/views/loading_view.dart';
import 'package:nappy_mobile/views/login_view.dart';
import 'package:nappy_mobile/widgets/loading_dialog.dart';

class HomeView extends ConsumerWidget {
  static const String id = "/home";

  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Option<UserModel> optionalData = ref.watch(userModelController);
    return optionalData.match(
      () {
        Navigator.pushNamed(context, LoginView.id);
        return const LoadingView();
      },
      (userModel) {
        final homeController = ref.watch(homeControllerProvider);

        return Scaffold(
          drawer: const AppDrawer(),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              children: [
                const Spacer(),
                ...List.generate(
                  userModel.cards.length,
                  (index) {
                    return CardPageIndicator(active: index == homeController.activePage);
                  },
                ),
                const Spacer(
                  flex: 2,
                ),
                const ShareButton(title: "SEND"),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: const Text('Nappy'),
            centerTitle: false,
            leading: Builder(
              // Provides a new context for the Drawer
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CardEditorView.id, arguments: CardOp.edit);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CardEditorView.id, arguments: CardOp.create);
                },
                icon: const Icon(
                  Icons.add_outlined,
                  size: 32,
                ),
              ),
              if (userModel.cards.isNotEmpty) ...{
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => DeleteCardDialog(
                      deleteClickHandler: () async {
                        Navigator.pop(context);
                        final CardModel activeCard = userModel.cards[homeController.activePage];
                        await ref.read(homeControllerProvider.notifier).deleteCard(
                              cardId: activeCard.cardId,
                              context: context,
                            );
                      },
                    ),
                  ),
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 32,
                  ),
                )
              }
            ],
          ),
          body: userModel.cards.isEmpty
              ? const GetStarted()
              : Column(
                  children: [
                    Flexible(
                      child: PageView.builder(
                        onPageChanged: ref.read(homeControllerProvider.notifier).onPageChanged,
                        itemCount: userModel.cards.length,
                        itemBuilder: (context, index) {
                          final CardModel card = userModel.cards[index];
                          return CardPresentation(
                            card: card,
                          );
                        },
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
