import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.email, required this.name});

  //* 이메일이랑 이름정보를 가져온다.
  final String? email;
  final String? name;

  static const empty = User(email: '', name: '');

  //* 비어있다면 유저의 empty 값 정보들을 가져온다.
  bool get isEmpty => this == User.empty;
  //* 비어있지 않다면 user.empty 값 정보를 가져오지 않는다.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object> get props => [];
}
