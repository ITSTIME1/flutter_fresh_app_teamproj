import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/bloc/simple_bloc_observer.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:fresh_app_teamproj/views/onboarding.dart';
import 'package:fresh_app_teamproj/views/splash.dart';
import 'package:fresh_app_teamproj/views/teachablemachine.dart';
import 'package:fresh_app_teamproj/bloc/authentication_state.dart';

// ** main 메소드는 건들지 않아도 됩니다.**
// WidgetsFlutterBinding.ensureInitialized(); => SharedPreferences 비동기로 데이터를 다루는거기 때문에 반드시 필요합니다.
// Firebase.initializeApp(); -> Firebase를 사용하기 위해서 명시해주어야 합니다.
// blocObserver: AuthenticationBlocObserver() -> 인증 절차를 밟을때 이벤트에 의해서 오류를 핸들링 하는 부분입니다.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () => runApp(const TeamApp()),
    blocObserver: AuthenticationBlocObserver(),
  );
}

// [TeamApp Bloc Logic]

// [AuthenticationInitial] => 앱이 빌드 되었을때 AuthenticationStarted가 실행되게 됩니다.
// AuthenticationStarted Event가 실행되면서 로그인 정보를 찾는 Logic 과정을 거치게 됩니다.
// 자세한 로직 정보는 [AuthenticationStarted] 확인할 수 있습니다.

// [AuthenticationSuccess] => AuthenticationStarted 로직을 수행한 후 로그인 정보를 가져왔을때 회원 정보가 Firebase Authentication 상에 있다면
// AuthenticationSuccess 클래스 내부에 있는 user 정보를 받고 [TeachableMachine] 페이지로 이동 되게 됩니다.

// [AuthenticationFailure] => AuthenticationStarted 로직을 수행한 후 로그인 정보가 없을때 [OnboardingScreen] 페이지로 이동 되게 됩니다.
// 이유는 로그인 정보가 없다는 의미는 '앱을 처음 시작한다.' 혹은 '앱을 런치하고 나서 로그인을 하지 않았다' 입니다.

class TeamApp extends StatefulWidget {
  const TeamApp({Key? key}) : super(key: key);

  @override
  State<TeamApp> createState() => _TeamAppState();
}

class _TeamAppState extends State<TeamApp> {
  final UserRepository _userRepository = UserRepository();
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: _userRepository)
          ..add(AuthenticationStarted()),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationInitial) {
              return const SplashScreen();
            }
            // TeachableMachine으로 이동.
            if (state is AuthenticationSuccess) {
              return TeachableMachine(userRepository: _userRepository);
            }
            if (state is AuthenticationFailure) {
              return OnboardingScreen(userRepository: _userRepository);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
