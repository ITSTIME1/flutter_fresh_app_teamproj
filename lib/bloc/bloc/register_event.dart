import 'package:equatable/equatable.dart';

// [Register Event]

// 회원가입 이벤트를 핸들링하는 곳입니다.
// 여기서 email, password 값을 전달 받습니다.

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

// RegisterState => Change to Email
class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

// RegisterState => Change to password
class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

// RegisterState => Click to submitted
class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  const RegisterSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
