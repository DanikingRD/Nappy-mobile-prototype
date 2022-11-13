import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/controllers/card_editor_controller.dart';
import 'package:nappy_mobile/models/badge.dart';
import 'package:nappy_mobile/models/badge_list_tile.dart';
import 'package:nappy_mobile/models/card_editor.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_grid.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_view.dart';
import 'package:nappy_mobile/views/card_editor/badges/phone_badge_view.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_editor_label.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_editor_text_field.dart';
import 'package:nappy_mobile/views/card_editor/widgets/edit_avatar_icon.dart';
import 'package:nappy_mobile/views/card_editor/widgets/editor_card_avatar.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_background.dart';
import 'package:nappy_mobile/views/card_editor/widgets/image_pick_dialog.dart';
import 'package:nappy_mobile/views/card_editor/widgets/reorderable_badge_text_field.dart';
import 'package:nappy_mobile/views/card_editor/widgets/theme_color_picker.dart';
import 'package:nappy_mobile/widgets/loading_dialog.dart';

// type of card operation
enum CardOp { edit, create }

const List<Badge> badges = [
  Badge("Phone Number", Icons.phone, ["Mobile", "Work", "Home", "Personal", "Business", "Cell", "Phone"]),
  Badge("Email", Icons.email, ["Business", "Work", "Personal"]),
  Badge("Link", Icons.link, ["Connect with me on LinkedIn"]),
  Badge("Address", Icons.location_on, ["Office", "Work", "Mailing Address", "Home"]),
  Badge("Discord", Icons.discord, ["Join our Discord server"]),
  Badge("Paypal", Icons.paypal, []),
  Badge("Telegram", Icons.telegram, ["Connect with me on Telegram"]),
  Badge("Facebook", Icons.facebook, ["Add me on Facebook"]),
  Badge("Tiktok", Icons.tiktok, ["Follow me on TikTok"]),
];

class CardEditorView extends ConsumerWidget {
  final CardOp op;
  static const String id = "/card_editor";

  const CardEditorView({
    super.key,
    required this.op,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cardEditorControllerProvider);
    const EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: 25);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.activeColor,
        title: Text(viewTitle),
        actions: [
          IconButton(
            onPressed: () => onCreateCard(ref),
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: horizontalPadding,
            child: CardEditorTextField(
              themeColor: controller.activeColor,
              controller: controller.cardTitleField.controller,
              labelText: "Set a card title (e.g Work or Personal)",
              floatingLabelAlign: FloatingLabelAlignment.center,
              textAlign: TextAlign.center,
              centeredLabel: true,
            ),
          ),
          vSpace(20),
          Padding(
            padding: horizontalPadding,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                ProfileBackground(
                  image: getBackgroundImage(controller),
                  onTap: () => onBackgroundClick(
                    context: context,
                    ref: ref,
                    hasCustomImage: controller.backgroundImage != null,
                  ),
                ),
                Positioned(
                  bottom: -30,
                  child: Stack(
                    children: const [
                      EditorCardAvatar(),
                      EditAvatarIcon(),
                    ],
                  ),
                )
              ],
            ),
          ),
          vSpace(60),
          ThemeColorPicker(
            activeColor: controller.activeColor,
            onChanged: (color) {
              ref.read(cardEditorControllerProvider.notifier).setActiveColor(color);
            },
          ),
          ...controller.fields.map((field) => _toTextField(field, controller.activeColor)).toList(),
          vSpace(30),
          const CardEditorLabel(
            label: "Drag end edit Badges",
            suffixIcon: Icons.touch_app,
          ),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: ((context, index) {
              final BadgeListTileModel listTile = controller.badgeModels[index];
              return ReorderableBadgeTextField(
                key: ValueKey("${listTile.title}$index"),
                titleController: TextEditingController(),
                subtitleController: TextEditingController(),
                badge: listTile,
                themeColor: controller.activeColor,
              );
            }),
            itemCount: controller.badgeModels.length,
            onReorder: (a, b) {},
          ),
          const CardEditorLabel(
            label: "Add Badges",
            suffixIcon: Icons.add,
          ),
          vSpace(30),
          BadgeGridView(
            badgeList: badges,
            onClick: (badge) {
              FocusManager.instance.primaryFocus?.unfocus();
              if (badge.label.contains("Phone Number")) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PhoneBadgeView(badge: badge, themeColor: controller.activeColor),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BadgeView(
                      badge: badge,
                      themeColor: controller.activeColor,
                    ),
                  ),
                );
              }
            },
            color: controller.activeColor,
          )
        ],
      ),
    );
  }

  ImageProvider<Object> getBackgroundImage(CardEditor editor) {
    if (editor.backgroundImage == null) {
      return const NetworkImage(
        "https://media.istockphoto.com/id/1298706128/vector/abstract-white-background-geometric-texture.jpg?b=1&s=612x612&w=0&k=20&c=Yq88qNqwJ2UWfujxAjS9F4cIAt05koQR20uk9NCQ4oo=",
      );
    } else {
      return FileImage(editor.backgroundImage!);
    }
  }

  Widget _toTextField(CardEditorField field, Color themeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: CardEditorTextField(
        themeColor: themeColor,
        controller: field.controller,
        labelText: field.title,
      ),
    );
  }

  String get viewTitle => op == CardOp.create ? "Create Card" : "Edit card";

  void onBackgroundClick({
    required BuildContext context,
    required WidgetRef ref,
    required bool hasCustomImage,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return ImagePickDialog(
          imageExits: hasCustomImage,
          pickHandler: () {
            ref.read(cardEditorControllerProvider.notifier).selectBackground(context);
          },
          removeHandler: () {
            ref.read(cardEditorControllerProvider.notifier).removeBackground(context);
          },
        );
      },
    );
  }

  void onCreateCard(WidgetRef ref) async {
    final navigator = Navigator.of(ref.context);
    showDialog(
      context: ref.context,
      barrierDismissible: false,
      builder: ((context) {
        return const LoadingDialog();
      }),
    );
    bool success = await ref.read(cardEditorControllerProvider.notifier).createCard(ref.context);
    if (success) {
      navigator.pop();
      navigator.pop();
    }
  }
}

class CardEditorField {
  final String title;
  final TextEditingController _controller;
  CardEditorField(this.title) : _controller = TextEditingController();
  TextEditingController get controller => _controller;
  String get text => _controller.text;

  void setText(String text) {
    controller.text = text;
  }
}
