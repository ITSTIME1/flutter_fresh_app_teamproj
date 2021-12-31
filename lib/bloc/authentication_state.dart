import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

//* 인증 상태 입니다 총 세가지로 이루어져 있습니다.
// 초기상태 -> 앱이 시작되고 있는 상태
// 성공상태 -> 앱의 인증이 완료된 상태입니다. (FirebaseUser email, id, photo) 등의 정보를 가져와야 합니다.
// 실패상태 -> 앱의 실패 상태입니다. 실패 상태는 따로 인증 화면을 SnackBar 화면으로 구현해주면 됩니다.

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
