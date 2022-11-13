import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/controllers/card_editor_controller.dart';
import 'package:nappy_mobile/models/card_editor.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utilities/firebase_constants.dart';
import 'package:nappy_mobile/views/card_editor/widgets/image_pick_dialog.dart';

class EditorCardAvatar extends StatelessWidget {
  const EditorCardAvatar({
    Key? key,
  }) : super(key: key);

  ImageProvider<Object> getImage(CardEditor editor) {
    if (editor.avatarImage == null) {
      return const CachedNetworkImageProvider(
        "https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png",
      );
    } else {
      return FileImage(editor.avatarImage!);
    }
  }

  void clickHandler(BuildContext context, CardEditor editor, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return ImagePickDialog(
          imageExits: editor.avatarImage != null,
          pickHandler: () {
            ref.read(cardEditorControllerProvider.notifier).selectAvatar(context);
          },
          removeHandler: () {
            ref.read(cardEditorControllerProvider.notifier).removeAvatar(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: Consumer(
        builder: (context, ref, child) {
          final editor = ref.watch(cardEditorControllerProvider);
          return editor.avatarImage == null
              ? CachedNetworkImage(
                  imageUrl: FirebaseConstants.defaultAvatarURL,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      color: Colors.black26,
                      width: 128,
                      height: 128,
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(
                      Icons.error,
                      color: kDangerColor,
                      size: 64,
                    );
                  },
                  imageBuilder: (context, imageProvider) {
                    return ImageContainer(
                      image: imageProvider,
                      clickHandler: () => clickHandler(context, editor, ref),
                    );
                  },
                )
              : ImageContainer(
                  image: FileImage(editor.avatarImage!),
                  clickHandler: () => clickHandler(context, editor, ref),
                );
        },
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final ImageProvider<Object> image;
  final VoidCallback clickHandler;
  const ImageContainer({
    super.key,
    required this.image,
    required this.clickHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        image: DecorationImage(image: image, fit: BoxFit.fill),
      ),
      child: InkWell(
        onTap: clickHandler,
      ),
    );
  }
}
