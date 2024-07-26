import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  User? get user => FirebaseAuth.instance.currentUser;

  Future<Either<String, Unit>> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await response.user?.updateDisplayName(name);

      return right(unit);
    } on FirebaseAuthException catch (err) {
      debugPrint(err.toString());
      if (err.code == 'weak-password') {
        return left('La contraseña proporcionada es demasiado débil.');
      } else if (err.code == 'email-already-in-use') {
        return left('El email ya se encuentra registrado.');
      }

      return left('Error inesperado.');
    } catch (err) {
      debugPrint(err.toString());
      return left('Error inesperado.');
    }
  }

  Future<Either<String, Unit>> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseAuthException catch (err) {
      debugPrint(err.toString());
      if (err.code == 'user-not-found') {
        return left('Email no encontrado.');
      } else if (err.code == 'wrong-password') {
        return left('Contraseña o usuario incorrectos.');
      }

      return left('Error inesperado.');
    } catch (err) {
      debugPrint(err.toString());
      return left('Error inesperado.');
    }
  }

  Future<Either<String, Unit>> logOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      return right(unit);
    } catch (err) {
      debugPrint(err.toString());
      return left('Error inesperado.');
    }
  }
}
