import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/bloc/simple_bloc_observer.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:fresh_app_teamproj/views/onboarding_page.dart';
import 'package:fresh_app_teamproj/views/signup_page.dart';
import 'package:fresh_app_teamproj/views/splash_scree_page.dart';
import 'package:fresh_app_teamproj/views/teachablemachine_page.dart';
import 'package:fresh_app_teamproj/bloc/authentication_state.dart';

// ** main 메소드는 건들지 않아도 됩니다.**
// WidgetsFlutterBinding.ensureInitialized(); -> SharedPreferences 비동기로 데이터를 다루는거기 때문에 반드시 필요합니다.

// Firebase.initializeApp(); -> Firebase 를 사용하기 위해서 명시해주어야 합니다.

// blocObserver: AuthenticationBlocObserver() -> 인증 절차를 밟을때 이벤트에 의해서 오류를 핸들링 하는 부분입니다.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  blocObserver:
  AuthenticationBlocObserver();

  runApp(TeamApp());
}

// ** TeamApp 은 BlocProvder 를 이용하여 AuthenticationBloc, AuthenticationState 참조한다음
// 상태에 따른 State 값을 변경하는 로직입니다.

// AuthenticationInitial -> 초기 화면은 미리 구현해둔 SplashScreen() 으로 시작됩니다.

// AuthenticationSuccess -> 만약 Firebase Store에 정보가 있다면 그 정보를 가져오는 로직을
// AuthenticationBloc 에서 로직을 돌립니다. 후에 그 정보값을 getUser() 값으로 불러와 State 값으로 전달합니다.
// 하여 만약 유저의 정보가 올바른 정보라면 TeachableMachine() 페이지로 반환합니다.

// AuthenticationFailure -> 인증의 실패한 경우입니다. 인증의 실패했다는건 isSignedIn 로직에서 로그인된 사용자 정보가 틀리거나
// 혹은 정보가 없을때 Failure 상태를 가져옵니다.

class TeamApp extends StatefulWidget {
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
              return SplashScreen();
            } else if (state is AuthenticationSuccess) {
              return TeachableMachine();
            } else if (state is AuthenticationFailure) {
              return BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(userRepository: _userRepository),
                child: LoginPage(userRepository: _userRepository),
              );
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
