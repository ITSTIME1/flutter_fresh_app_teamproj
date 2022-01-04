// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// ** 비밀번호를 잊어 먹었을때 찾을 수 있는 페이지입니다.
// Bloc Pattern으로 제작되어야 하며 기능은 추가 예정입니다.

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const TextField(),
              RaisedButton(onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
