import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// * 유효성 검사.
// * email validator
// * password validator

class CheckValidate {
  String? validateEmail(FocusNode focusNode, String value) {
    // 칸이 비어있다면
    if (value.isEmpty) {
      focusNode.requestFocus();
      return '이메일을 입력하세요.';
      // 그렇지 않고 @ 포함이 되어 있지 않다면
    } else if (!value.contains('@')) {
      focusNode.requestFocus();
      return '올바른 이메일 형식이 아닙니다';
    } else {
      const pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        focusNode.requestFocus(); //포커스를 해당 textformfield에 맞춘다.
        return '잘못된 이메일 형식입니다.';
      } else {
        return null;
      }
    }
  }

  //* Password Validator

  String? validatePassword(FocusNode focusNode, String value) {
    if (value.isEmpty) {
      focusNode.requestFocus();
      return '비밀번호를 입력하세요.';
    } else {
      const pattern =
          r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
      RegExp regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        focusNode.requestFocus();
        return '특수문자, 대소문자, 숫자 포함 8자 이상 15자 이내로 입력하세요.';
      } else {
        return null;
      }
    }
  }
}
