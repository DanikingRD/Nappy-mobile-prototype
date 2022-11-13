import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/providers/firebase_providers.dart';
import 'package:nappy_mobile/utilities/firebase_constants.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  Future<Either<String, UserCredential>> logIn(String email, String password) async {
    try {
      final UserCredential creds = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(creds);
    } on FirebaseAuthException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> signOut() async {
    try {
      await _auth.signOut();
      return right(null);
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, UserCredential>> registerWithEmail(String email, String password) async {
    try {
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(credential);
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, void>> deleteUser() async {
    try {
      _auth.currentUser!.delete();
      return right(null);
    } on FirebaseException catch (e) {
      return left(e.message!);
    } catch (e) {
      return left(e.toString());
    }
  }

  Stream<Option<User>> get authStateChanges => _auth.authStateChanges().map((event) {
        return Option.fromNullable(event);
      });
  CollectionReference get _users => _firestore.collection(FirebaseConstants.userCollection);
}
