import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

//** TeachableMachine 위젯은 메인기능 페이지입니다.
// 메인 페이지 기능은 아직 구현이 되지 않았습니다.
// 구현이 되면 이 페이지에 추가될 예정입니다.
class TeachableMachine extends StatefulWidget {
  final UserRepository _userRepository;
  const TeachableMachine({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _TeachableMachineState createState() => _TeachableMachineState();
}

class _TeachableMachineState extends State<TeachableMachine> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: () async {
                try {
                  await _firebaseAuth.signOut();
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                }
              },
              icon: const Icon(Icons.backpack_rounded),
            );
          }),
        ],
        title: const Text('Teachable Machine'),
      ),
    );
  }
}
