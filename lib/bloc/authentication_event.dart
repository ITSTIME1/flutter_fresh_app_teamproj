import 'package:equatable/equatable.dart';

// ** 앱의 이벤트를 처리하는 부분입니다.
// AuthenticationState 와 AuthenticationEvent 는 서로 연결되어 있으며,
// Event 에 의해서 State 상태가 변경되게 됩니다. (자세한 내용은 AuthenticationBloc 에서 설명하도록 하겠습니다.)
// AuthenticationStarted -> 앱이 시작 되었을때를 의미합니다. -> 앱이 시작되면 인증정보를 불러와야 할 것입니다.
// AuthenticationLoggedIn -> 앱의 로그인이 되었을때 입니다. -> 앱이 로그인이 되었다는 뜻은 로그인 정보가 성공적으로 받아왔음을 의미합니다.
// AuthenticationLoggedOut -> 앱의 로그아웃 이 되었을때 입니다. -> 로그아웃이 되었다는 뜻은 정보가 성공적으로 삭제되었음을 의미합니다. (실제로 데이터가 삭제 되는건 X) -> 유저의 정보 자체를 FirebaseStore에서 삭제하는 방법을 제외하고는 유저의 정보는 삭제되지 않습니다.

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}
