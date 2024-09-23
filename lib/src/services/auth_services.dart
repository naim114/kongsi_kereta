import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kongsi_kereta/src/services/user_services.dart';

import '../model/user_model.dart';
import 'role_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<UserModel?> get onAuthStateChanged {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) {
        return null;
      } else {
        try {
          final authStateChanges = _auth.authStateChanges();
          print("authStateChanges: ${authStateChanges.toString()}");

          final tokenChanges = _auth.idTokenChanges();
          print("tokenChanges: ${tokenChanges.toString()}");

          return await UserServices().getUserModelFromFirebase(user);
        } catch (e) {
          print(e.toString());
          return null;
        }
      }
    });
  }

  // sign up with email & password
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Encrypt password
      var bytes = utf8.encode(password);
      var digest = sha1.convert(bytes);

      // Create user credential
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: digest.toString(),
      );

      // Get result
      User user = result.user!;

      // Initialize role
      final userRole = await RoleServices().getBy('name', 'user');

      // Add to firestore
      if (userRole.isNotEmpty) {
        await _db.collection("User").doc(user.uid).set(
              UserModel(
                name: name,
                createdAt: DateTime.now(),
                email: email,
                password: digest.toString(),
                role: userRole.first,
                id: user.uid,
                updatedAt: DateTime.now(),
              ).toJson(),
            );
      }

      Fluttertoast.showToast(msg: "Sign up success!");

      final addedUser = await UserServices().get(user.uid);

      print("Added: $addedUser");

      if (addedUser != null) {
        return addedUser;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString().contains(
                  'email address is already in use by another account')
              ? "The email address is already in use by another account."
              : e.toString());

      return null;
    }
  }

  // sign in with email and password
  Future signIn(
    String email,
    String password,
  ) async {
    try {
      // Encrypt password
      var bytes = utf8.encode(password);
      var digest = sha1.convert(bytes);

      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: digest.toString(),
      )
          .then((userCred) async {
        await UserServices().get(userCred.user!.uid).then((user) async {
          if (user != null) {
            // check if user is disabled
            if (user.disableAt != null) {
              print("Disable at: ${user.disableAt}");

              Fluttertoast.showToast(
                  msg:
                      "User is disabled. Please contact admin to get this account back.");

              await _auth.signOut();

              return false;
            }
          }
        });
      });

      return true;
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());

      return false;
    }
  }

  //sign out
  Future signOut(UserModel user) async {
    try {
      await UserServices().get(user.id);

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
