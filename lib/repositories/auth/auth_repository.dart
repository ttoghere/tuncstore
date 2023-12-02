// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:tuncstore/models/models.dart';
import 'package:tuncstore/repositories/auth/base_auth_repository.dart';
import 'package:tuncstore/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository(
      {auth.FirebaseAuth? firebaseAuth, required UserRepository userRepository})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  @override
  Future<auth.User?> signUp({
    required String password,
    required User user,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      )
          .then((value) {
        _userRepository.createUser(
          user.copyWith(id: value.user!.uid),
        );
      });
    } catch (_) {}
  }

  @override
  Future<void> logInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      // FirebaseAuthException türündeki hataları işle
      if (e.code == 'user-not-found') {
        // Kullanıcı bulunamadı hatası
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "An Error Occured",
                  ),
                  content: Text("Error: ${e.message}"),
                ));
      } else if (e.code == 'wrong-password') {
        // Yanlış şifre hatası
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "An Error Occured",
                  ),
                  content: Text("Error: ${e.message}"),
                ));
      } else {
        // Diğer hatalar
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text(
                    "An Error Occured",
                  ),
                  content: Text("Error: ${e.message}"),
                ));
      }
    } catch (e) {
      // FirebaseAuthException dışındaki genel hataları işle
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text(
                  "An Error Occured",
                ),
                content: Text("Error: $e"),
              ));
    }
  }

  void sendPasswordResetEmail(
      {required String email, required BuildContext context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on auth.FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("An Error Occured"),
          content: Text(
            e.message.toString(),
          ),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("An Error Occured"),
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
