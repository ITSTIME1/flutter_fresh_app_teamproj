import 'dart:async';
import 'package:fresh_app_teamproj/repository/user.dart';

class UserRepository {
  User? _user;

  // 유저의 정보를 갖고 오기
  Future<User?> getUser() async {
    if (_user != null) {
      return _user;
    }
  }
}
