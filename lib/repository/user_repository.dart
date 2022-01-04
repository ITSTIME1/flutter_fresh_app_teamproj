import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// ** 유저 정보 저장소입니다 회원가입 메서드, 로그인 메서드
// 로그아웃, 사용자 정보 가져오기 등의 메서드가 있습니다.
// 추가적으로 UI에 표시될 이름, 이메일, photo 등의 정보를 가져오는 메서드를 추가해야 합니다.

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  //* 회원가입 메서드.
  Future<UserCredential?> signUp(String? email, String? password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  //* 로그인 메서드
  Future<void> logIn(String? email, String? password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email!.trim(),
        password: password!.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  //* 로그아웃 메서드
  Future<void> logOut() async {
    return await _firebaseAuth.signOut();
  }

  //* 로그인완료된 사용자 정보 가져오기
  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    return _firebaseAuth.currentUser;
  }
}
