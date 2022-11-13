import 'package:flutter/foundation.dart';

import 'package:nappy_mobile/models/card.dart';

@immutable
class UserModel {
  final String uid;
  final String email;
  final List<CardModel> cards;

  const UserModel({
    required this.uid,
    required this.email,
    required this.cards,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    List<CardModel>? cards,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      cards: cards ?? this.cards,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'cards': cards.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      cards: toCardsList(map['cards']),
    );
  }

  static List<CardModel> toCardsList(dynamic data) {
    if (data == null) {
      return [];
    }
    return (data as Iterable).map<CardModel>(
      (card) {
        return CardModel.fromMap(card as Map<String, dynamic>);
      },
    ).toList();
  }

  @override
  String toString() => 'UserModel(uid: $uid, email: $email, cards: $cards)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.email == email && listEquals(other.cards, cards);
  }

  @override
  int get hashCode => uid.hashCode ^ email.hashCode ^ cards.hashCode;
}
