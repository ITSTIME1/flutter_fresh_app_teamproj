import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                ),
                const Text(
                  'Fresh',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '무엇을 원하시나요?',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
