// ** 유효성 검사 클래스 입니다.
// 이메일, 패스워드 유효성 검사로 이루어져 있으며 각각 전자메일, 전자암호의 대한 유효성 검사를 실시합니다.

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$',
  );

  // 수정 사항 필요
  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  // 수정 사항 필요
  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
