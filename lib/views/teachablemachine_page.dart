import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

//** TeachableMachine 위젯은 메인기능 페이지입니다.
// 메인 페이지 기능은 아직 구현이 되지 않았습니다.
// 구현이 되면 이 페이지에 추가될 예정입니다.
class TeachableMachine extends StatefulWidget {
  @override
  _TeachableMachineState createState() => _TeachableMachineState();
}

class _TeachableMachineState extends State<TeachableMachine> {
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                authenticationBloc.add(AuthenticationLoggedOut());
              },
              icon: Icon(Icons.backpack_rounded),
            );
          }),
        ],
        title: Text('메인화면'),
      ),
    );
  }
}

// body: Builder(
//           builder: (BuildContext newContext) {
//             return RaisedButton(
//               onPressed: () {
//                 newContext
//                     .read<AuthenticationBloc>()
//                     .add(AuthenticationLoggedOut());
//               },
//               child: Text('LogOut'),
//             );
//           },
//         ),