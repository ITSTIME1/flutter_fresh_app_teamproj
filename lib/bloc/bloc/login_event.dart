import 'package:equatable/equatable.dart';

// [Login Event]

// Email, Password, GooglePressed
// 로그인 이벤트를 핸들링하는 곳입니다.

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

// 로그인 이메일
class LoginEmailChanged extends LoginEvent {
  final String email;
  const LoginEmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LoginEmailChanged { email :$email }';
}

// 로그인 패스워드
class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged({required this.password});
  final String password;

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'LoginPasswordChanged { password: $password }';
}

// 로그인 이벤트
class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}

// 구글로그인 이벤트
class LoginWithGooglePressed extends LoginEvent {}
