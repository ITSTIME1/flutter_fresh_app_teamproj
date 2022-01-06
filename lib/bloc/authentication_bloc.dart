import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/bloc/authentication_state.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

// ** Bloc Pattern은 Event, State를 연결하는데 의미가 있습니다.
// AuthenticationBloc 부분은 말 그대로 인증 부분을 Bloc Pattern으로 연결한다는 의미입니다.
// Bloc 8.0.0 Update 사항으로 StreamMap 메서드가 사라지고 on<event>(event, emit) 핸들러를 사용해야 합니다. (메서드에 주의하십시오)
// AuthetnciationBloc 에서는 이전의 만들어 두었던 앱이 시작하는 상태 AuthenticationInitial(State) = AuthenticationStarted(evnet) 상태를 연결합니다.
// 추가해야 될 부분은 try catch 구분을 활용해서 Exception을 알려주어야 합니다.

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial()) {
    // on<Event> handler 부분입니다. EventHandleName은 AutheticationEvent 이름을 따왔습니다.
    on<AuthenticationStarted>(_onStarted);
    on<AuthenticationLoggedIn>(_onLoggedIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
  }
  // void 메서드로 불러도 되지만 Future asnyc 방식을 사용한 이유는 유저의 정보값을 받아오는 과정이 먼저 진행이 되어야 하기 때문입니다.
  // 만약 비동기방식으로 진행이 되지 않았다면 유저의 정보를 받아오기전에 UI가 보여지는 부분이나 혹은 그 외에 다른 오류가 나타날 수 있기 때문에
  // 비동기 방식으로 불러오는건 중요합니다.
  // 만약 메서드를 추가해야할 사항이 있다면 AuthenticationBloc 내부 로직에서는 Future asnyc 로직을 따라주시면 됩니다. :)
  Future<void> _onStarted(
      AuthenticationStarted event, Emitter<AuthenticationState> emit) async {
    final isSignedIn = await _userRepository.isSignedIn();
    // User information
    if (isSignedIn) {
      final firebaseUser = await _userRepository.getUser();
      await Future.delayed(const Duration(seconds: 10));
      emit(AuthenticationSuccess(firebaseUser: firebaseUser!));
    } else {
      await Future.delayed(const Duration(seconds: 10));
      emit(AuthenticationFailure());
    }
  }

  Future<void> _onLoggedIn(
      AuthenticationLoggedIn event, Emitter<AuthenticationState> emit) async {
    await Future.delayed(const Duration(seconds: 5));
    emit(AuthenticationSuccess(firebaseUser: await _userRepository.getUser()));
  }

  // ** 로그아웃 메서드
  // 로그아웃시에 인증 실패 화면을 보여주면 회원가입 페이지를 보내기 때문에
  // 추가적으로 상태를 한개더 만들어서 LogOut시에 -> Teachablemachine 페이지로 갈 수 있게끔 한다.
  Future<void> _onLoggedOut(
      AuthenticationLoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationFailure());
    await _userRepository.logOut();
  }
}
