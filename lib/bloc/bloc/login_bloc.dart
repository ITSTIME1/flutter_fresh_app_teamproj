import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_state.dart';
import 'package:fresh_app_teamproj/bloc/bloc/validators.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository? _userRepository;

  LoginBloc({
    required UserRepository userRepository,
  }) : super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithCredentialsPressed>(_onWithChanged);
  }

  Future<LoginState?> _onEmailChanged(
      LoginEmailChanged event, Emitter<LoginState> emit,
      {String? email}) async {
    if (email != null) {
      emit(state.update(isEmailValid: Validators.isValidEmail(email)));
    }
  }

  Future<LoginState?> _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit,
      {String? password}) async {
    if (password != null) {
      emit(state.update(isPasswordValid: Validators.isValidPassword(password)));
    }
  }

  Future<LoginState?> _onWithChanged(
      LoginWithCredentialsPressed event, Emitter<LoginState> emit,
      {String? email, String? password}) async {
    emit(LoginState.loading());
    try {
      final logedUser =
          await _userRepository!.signInWithEmailAndPassword(email!, password!);
      if (logedUser != null) {
        emit(LoginState.success());
      }
    } catch (_) {
      emit(LoginState.failure());
    }
  }
}
