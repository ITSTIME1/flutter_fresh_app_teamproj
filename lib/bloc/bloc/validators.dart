// ** 유효성 검사 클래스 입니다.
// 이메일, 패스워드 유효성 검사로 이루어져 있으며 각각 전자메일, 전자암호의 대한 유효성 검사를 실시합니다.

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  // 수정 사항 필요
  static isValidEmail(String email) {
    if (email.isEmpty) {
      return '이메일을 입력하세요';
    } else if (email.contains('@')) {
      return '이메일형식을 확인해주세요';
    } else {
      return _emailRegExp.hasMatch(email);
    }
  }

  // 수정 사항 필요
  static isValidPassword(String password) {
    if (password.isEmpty) {
      return '비밀번호를 입력하세요';
    } else if (password.length < 8) {
      return '비밀번호형식을 확인해주세요';
    } else {
      return _passwordRegExp.hasMatch(password);
    }
  }
}
