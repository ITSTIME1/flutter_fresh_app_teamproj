import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

//* 초기상태.
class AuthenticationInitial extends AuthenticationState {}

//* 성공상태.
class AuthenticationSuccess extends AuthenticationState {
  final User? firebaseUser;

  AuthenticationSuccess({required this.firebaseUser});

  @override
  List<Object> get props => [];
  @override
  String toString() =>
      'AuthenticationStateSuccess, email: ${firebaseUser!.email}';
}

//* 실패 상태.
class AuthenticationFailure extends AuthenticationState {}
