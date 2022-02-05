import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_state.dart';
import 'package:fresh_app_teamproj/bloc/bloc/validators.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

// [Login Bloc]

// LoginEvent & LoginState 값을 연결하는 공간 입니다.
// LoginEvent 값이 실행되었을때 상태가 어떻게 변하는지 핸들링합니다.
// ex) _onRegisterEmailChanged 의 email 값을 Validators를 먼저 거쳐서 유효성 검사를 받은다음 state.update 해줍니다.
// 그렇다면 isValidEmail(email) 값은 update로 이어져 적용이됩니다.

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithCredentialsPressed>(_onLoginSubmitChanged);
    on<LoginWithGooglePressed>(_onLoginWithGoogle);
  }

  Future<void> _onEmailChanged(
      LoginEmailChanged event, Emitter<LoginState> emit,
      {String? email}) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  Future<void> _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit,
      {String? password}) async {
    emit(state.update(
        isPasswordValid: Validators.isValidPassword(event.password)));
  }

  Future<void> _onLoginSubmitChanged(
      LoginWithCredentialsPressed event, Emitter<LoginState> emit) async {
    emit(LoginState.loading());
    try {
      await _userRepository.logIn(email: event.email, password: event.password);
      emit(LoginState.success());
    } catch (_) {
      emit(LoginState.failure());
    }
  }

  Future<void> _onLoginWithGoogle(
      LoginWithGooglePressed event, Emitter<LoginState> emit) async {}
}
