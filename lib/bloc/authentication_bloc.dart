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
    on<AuthenticationLoggedOut>(_onLoggedOut);
  }

  //* App started
  Future<void> _onStarted(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    final isSignedIn = await _userRepository.isSignedIn();
    // 현재의 정보가 null 값이 아니라면
    if (isSignedIn) {
      // 그 현재 우저의 정보를 firebaseUser에 담고.
      final User? firebaseUser = await _userRepository.getUser();
      // 성공적인 화면을 보여주기 위해 상태는 인증성공 상태로 돌려준다.
      // 하여 인증 성공 이라는 값은 main.dart에서 TeachablemachinePage로 돌려준다.
      emit(AuthenticationSuccess(firebaseUser: firebaseUser));
      // 만약 currentUser 값이 null 값이라면 인증 실패 상태를 준다.
    } else {
      emit(AuthenticationFailure());
    }
  }

  //* App LoggedIn
  Future<void> _onLoggedIn(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationSuccess());
  }

  //* App LoggedOut
  Future<void> _onLoggedOut(
      AuthenticationEvent event, Emitter<AuthenticationState> emit) async {}
}
