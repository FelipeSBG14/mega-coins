import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../core/exceptions/auth_exception.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredencial.user;
    } on PlatformException catch (e, s) {
      log(
        'Não foi possível logar',
        error: e,
        stackTrace: s,
      );
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) {
      log('Não foi possível realizar o login Firebase',
          error: e, stackTrace: s);
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login ou senha inválidos');
      }
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }
}
