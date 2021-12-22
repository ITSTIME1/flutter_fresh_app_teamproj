import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';

import 'package:fresh_app_teamproj/bloc/authentication_state.dart';

import 'package:fresh_app_teamproj/repository/authentication_repository.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fresh_app_teamproj/views/login_page.dart';
import 'package:fresh_app_teamproj/views/signup_page.dart';
import 'package:fresh_app_teamproj/views/splash_scree_page.dart';
import 'package:fresh_app_teamproj/views/teachablemachine_page.dart';

import 'bloc/authentication_bloc.dart';

/* Fresh 앱 비동기 방식
  Bloc Pattern 으로 작성되었음.
  dadad
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  authenticationRepository:
  AuthenticationRepository();
  runApp(TeamApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

class TeamApp extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  const TeamApp(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: TeamAppView(),
      ),
    );
  }
}

class TeamAppView extends StatefulWidget {
  @override
  _TeamAppViewState createState() => _TeamAppViewState();
}

class _TeamAppViewState extends State<TeamAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            //* 인증이 된 상태일 경우 LoginPage
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  TeachableMachine.route(),
                  (route) => false,
                );
                break;
              //* 인증이 되지 않은 상태일경우엔 SignUppage
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  SignUp.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      //* 기본적인 화면은 SplashScreen
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
