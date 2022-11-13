import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/controllers/card_editor_controller.dart';
import 'package:nappy_mobile/models/card_editor.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/widgets/edit_avatar_icon.dart';
import 'package:nappy_mobile/views/card_editor/widgets/editor_card_avatar.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_background.dart';
import 'package:nappy_mobile/views/card_editor/widgets/image_pick_dialog.dart';
import 'package:nappy_mobile/views/card_editor/widgets/theme_color_picker.dart';
import 'package:nappy_mobile/widgets/loading_dialog.dart';

// type of card operation
enum CardOp { edit, create }

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        children: [
          TextFormField(
            textAlign: TextAlign.center,
            controller: controller.cardTitleField.controller,
            decoration: const InputDecoration(
              filled: false,
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              label: Center(
                child: Text(
                  "Set a card title (e.g Work or Personal)",
                ),
              ),
              floatingLabelStyle: TextStyle(color: kPrimaryColor),
              alignLabelWithHint: true,
              floatingLabelAlignment: FloatingLabelAlignment.center,
            ),
          ),
          vSpace(20),
          Stack(
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
          vSpace(60),
          ThemeColorPicker(
            activeColor: controller.activeColor,
            onChanged: (color) {
              ref.read(cardEditorControllerProvider.notifier).setActiveColor(color);
            },
          ),
          ...controller.fields.map(_toTextField).toList(),
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

  Widget _toTextField(CardEditorField field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: field.controller,
        decoration: InputDecoration(
          filled: false,
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor, width: 2.0),
          ),
          floatingLabelStyle: const TextStyle(color: kPrimaryColor),
          alignLabelWithHint: true,
          labelText: field.title,
        ),
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
}
