import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/bloc/authentication_state.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onStarted);
    on<AuthenticationLoggedIn>(_onLoggedIn);
  }
  Future<void> _onStarted(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      final firebaseUser = await _userRepository.getUser();
      emit(AuthenticationSuccess(firebaseUser: firebaseUser!));
    } else {
      emit(AuthenticationFailure());
    }
  }

  Future<void> _onLoggedIn(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSuccess(firebaseUser: await _userRepository.getUser()));
  }
}
