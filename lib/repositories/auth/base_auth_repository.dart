import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:tuncstore/models/models.dart';

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<auth.User?> signUp({
    required User user,
    required String password,
  });
  Future<void> logInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context});
  Future<void> signOut();
}
