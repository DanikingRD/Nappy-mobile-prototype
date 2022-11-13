import 'package:flutter/material.dart';

@immutable
class CardModel {
  final String cardId;
  final String title;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String company;
  final String background;
  final String avatar;
  final int color;

  const CardModel({
    required this.cardId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.company,
    required this.background,
    required this.avatar,
    required this.color,
  });

  CardModel copyWith({
    String? cardId,
    String? title,
    String? firstName,
    String? lastName,
    String? jobTitle,
    String? company,
    String? background,
    String? avatar,
    int? color,
  }) {
    return CardModel(
      cardId: cardId ?? this.cardId,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      background: background ?? this.background,
      avatar: avatar ?? this.avatar,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardId': cardId,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'jobTitle': jobTitle,
      'company': company,
      'background': background,
      'avatar': avatar,
      'color': color,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      cardId: map['cardId'] as String,
      title: map['title'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      jobTitle: map['jobTitle'] as String,
      company: map['company'] as String,
      background: map['background'] as String,
      avatar: map['avatar'] as String,
      color: map['color'] as int,
    );
  }

  @override
  String toString() {
    return 'CardModel(cardId: $cardId, title: $title, firstName: $firstName, lastName: $lastName, jobTitle: $jobTitle, company: $company, background: $background, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant CardModel other) {
    if (identical(this, other)) return true;

    return other.cardId == cardId &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.jobTitle == jobTitle &&
        other.company == company &&
        other.background == background &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return cardId.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        jobTitle.hashCode ^
        company.hashCode ^
        background.hashCode ^
        avatar.hashCode;
  }
}
