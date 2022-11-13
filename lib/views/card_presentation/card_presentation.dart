import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nappy_mobile/models/card.dart';
import 'package:nappy_mobile/utilities/constants.dart';
import 'package:nappy_mobile/utils.dart';
import 'dart:math' as math;

import 'package:nappy_mobile/views/card_presentation/widgets/card_header.dart';
import 'package:nappy_mobile/views/card_presentation/widgets/card_title_container.dart';

class CardPresentation extends StatelessWidget {
  final CardModel card;
  const CardPresentation({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              vSpace(20),
              CardHeaderPresentation(
                avatarImage: CachedNetworkImageProvider(
                  card.avatar,
                ),
                backgroundImage: CachedNetworkImageProvider(
                  card.background,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Opacity(
                opacity: 0.4,
                child: Divider(
                  thickness: 5.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CardTitleContainer(
                fullName: "${card.firstName} ${card.lastName}",
                jobTitle: card.jobTitle,
                company: card.company,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Digiwtal artist, Adobe Creative Cloud master with over 8 years of in-house design experience.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              const Badge(
                icon: Icon(
                  Icons.phone,
                ),
                title: '+1 202 555 0101',
                subtitle: 'mobile',
              ),
              const Badge(
                icon: Icon(
                  Icons.email,
                ),
                title: 'Adrian@creativestudio.com',
                subtitle: 'email',
              ),
              const Badge(
                icon: Icon(
                  Icons.location_on,
                ),
                title: '221B Barker St., London UK',
                subtitle: 'location',
              ),
              const Badge(
                icon: Icon(
                  Icons.location_on,
                ),
                title: '221B Barker St., London UK',
                subtitle: 'location',
              ),
              vSpace(200),
            ],
          ),
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subtitle;
  const Badge({super.key, required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero, // override default
      iconColor: Colors.white,
      leading: FloatingActionButton(
        heroTag: Text(title),
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        child: icon,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}

class ShareButton extends StatelessWidget {
  final String title;
  const ShareButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onPressed: () {},
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Transform.rotate(
                angle: -22 * math.pi / 100,
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.send,
                  size: 24,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
