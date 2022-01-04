import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback? _onPressed;

  const RegisterButton({Key? key, VoidCallback? onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(15),
      // 눌렀을때 조건에 맞는 validate 값을 상태변환 시켜줌.
      onPressed: _onPressed,
      child: const Text(
        '회원가입',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
