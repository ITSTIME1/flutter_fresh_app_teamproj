import 'package:meta/meta.dart';

// [Register State]

// Register State 부분은 이메일, 패스워드, 제출, 실패, 성공
// bool type 을 지향합니다.
// ex) RegisterState.initial() 상태라면 이메일, 패스워드 값은 트루값으로 바꾸어주고, 제출이랑, 성공 or 실패의 상태는 모르기 때문에 false로 지정합니다.
// 후에 RegisterState.Success() 가 되었을시에 boolean 값을 보면 쉽게 확인이 됩니다.

// immutable => 변경 불가능한 상태로 만들기 위해서 지정했습니다.
@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  // 둘다 true 값으로 되어있을시에
  bool get isFormValid => isEmailValid && isPasswordValid;

  const RegisterState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return const RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool? isEmailValid,
    bool? isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitEnabled,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  // @override
  // String toString() {
  //   return '''LoginState {
  //     isEmailValid: $isEmailValid,
  //     isPasswordValid: $isPasswordValid,
  //     isSubmitting: $isSubmitting,
  //     isSuccess: $isSuccess,
  //     isFailure: $isFailure,
  //   }''';
  // }
}
