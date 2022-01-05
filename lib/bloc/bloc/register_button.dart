import 'package:flutter/material.dart';

// [Register Button]

// 회원가입 버튼만 따로 Extract 한 것입니다.
// 빼도 안빼도 상관은 없지만 UI 부분과 onPressed 부분을 조금 나누기 위해서
// 보기 쉽게 뺐습니다.

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
