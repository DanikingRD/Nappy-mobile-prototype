import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/models/card.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/providers/firebase_providers.dart';
import 'package:nappy_mobile/utilities/firebase_constants.dart';

final userModelRepository = Provider((ref) {
  return UserModelRespository(
    firestore: ref.watch(firestoreProvider),
  );
});

class UserModelRespository {
  final FirebaseFirestore _firestore;

  UserModelRespository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  Future<Either<String, UserModel>> readUserModel(String id) async {
    try {
      final map = await _firestore.collection(FirebaseConstants.userCollection).doc(id).get();
      if (map.data() != null) {
        return right(UserModel.fromMap(map.data()!));
      }
      return left("User data does not exists");
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> mergeModel({
    required String uid,
    required UserModel toMerge,
  }) async {
    try {
      return right(_users.doc(uid).update(toMerge.toMap()));
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> createModel({
    required UserModel model,
  }) async {
    try {
      return right(_users.doc(model.uid).set(model.toMap()));
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  CollectionReference get _users => _firestore.collection(FirebaseConstants.userCollection);
}
