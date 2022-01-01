import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/model/sizeconfigs_page.dart';
import 'package:fresh_app_teamproj/data/model/validators.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:fresh_app_teamproj/views/teachablemachine_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ** 회원가입 페이지 입니다.
// 회원가입을 할 수 있도록 만들어진 페이지입니다.
// Bloc Pattern 으로 제작되어야 하며, Login Bloc를 참조하시면 됩니다.

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final UserRepository _userRepository = UserRepository();
  FocusNode _userNameFoucus = new FocusNode();
  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  FocusNode _confirmPasswordFocus = new FocusNode();

  String signUsername = '';
  String signEmail = '';
  String signPassword = '';
  String signConfirmPassword = '';
  bool isPasswordVisible = false;

  //* 사용자가 이메일, 패스워드를 사용할 수 있게 해주는 메서드.
  final _authentication = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //* 상태 업데이트.
  void initState() {
    _userNameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
    super.initState();
  }

  //* 상태 종료.
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _tryValidation() {
    final isValid = _formkey.currentState!.validate();
    if (isValid) {
      _formkey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    var errorMessage = '';
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Image.asset(
                    'lib/images/Signupimg.png',
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 650,
                    width: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'SignUp',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        // * UserName

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            focusNode: _userNameFoucus,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '이름을 정해주세요!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              signUsername = value!;
                            },
                            onChanged: (value) {
                              signUsername = value;
                            },
                            controller: _userNameController,
                            decoration: InputDecoration(
                              suffixIcon: _userNameController.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      icon: Icon(Icons.close,
                                          color: Colors.grey[600]),
                                      onPressed: () =>
                                          _userNameController.clear(),
                                    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              ),
                              labelText: '프로필 이름',
                              labelStyle: TextStyle(
                                  color: _userNameFoucus.hasFocus
                                      ? Colors.green
                                      : Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),

                        // * Email field Logic

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            focusNode: _emailFocus,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => CheckValidate()
                                .validateEmail(_emailFocus, value!),
                            onSaved: (value) {
                              signEmail = value!;
                            },
                            onChanged: (value) {
                              signEmail = value;
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                              suffixIcon: _emailController.text.isEmpty
                                  ? Container(width: 0)
                                  : IconButton(
                                      icon: Icon(Icons.close,
                                          color: Colors.grey[600]),
                                      onPressed: () => {
                                        _emailController.clear(),
                                      },
                                    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              ),
                              labelText: '이메일',
                              labelStyle: TextStyle(
                                  color: _emailFocus.hasFocus
                                      ? Colors.green
                                      : Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // * Password field Logic

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            focusNode: _passwordFocus,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) => CheckValidate()
                                .validatePassword(_passwordFocus, value!),
                            onSaved: (value) {
                              signPassword = value!;
                            },
                            onChanged: (value) {
                              signPassword = value;
                            },
                            obscureText: isPasswordVisible,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: '비밀번호',
                              labelStyle: TextStyle(
                                  color: _passwordFocus.hasFocus
                                      ? Colors.green
                                      : Colors.black),
                              suffixIcon: _passwordController.text.isEmpty
                                  ? null
                                  : Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _passwordController.clear();
                                          },
                                          icon: Icon(Icons.close,
                                              color: Colors.grey[600]),
                                        ),
                                        IconButton(
                                          onPressed: () => setState(() =>
                                              isPasswordVisible =
                                                  !isPasswordVisible),
                                          icon: isPasswordVisible
                                              ? Icon(Icons.visibility_off,
                                                  color: Colors.red)
                                              : Icon(Icons.visibility,
                                                  color: Colors.green),
                                        ),
                                      ],
                                    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ),
                          ),
                        ),

                        //* Confirm password field Logic

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            focusNode: _confirmPasswordFocus,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '비밀번호를 입력해주세요';
                              }
                              if (value != _passwordController.text) {
                                return '비밀번호가 일치하지 않습니다.';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              signConfirmPassword = value!;
                            },
                            //* 입력한 값을 가져오기 위해서 저장을 함.
                            onChanged: (value) {
                              signConfirmPassword = value;
                            },
                            obscureText: isPasswordVisible,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: '비밀번호 확인',
                              labelStyle: TextStyle(
                                  color: _confirmPasswordFocus.hasFocus
                                      ? Colors.green
                                      : Colors.black),
                              suffixIcon: _confirmPasswordController
                                      .text.isEmpty
                                  ? null
                                  : Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            _confirmPasswordController.clear();
                                          },
                                          icon: Icon(Icons.close,
                                              color: Colors.grey[600]),
                                        ),
                                        IconButton(
                                          onPressed: () => setState(() =>
                                              isPasswordVisible =
                                                  !isPasswordVisible),
                                          icon: isPasswordVisible
                                              ? Icon(Icons.visibility_off,
                                                  color: Colors.red)
                                              : Icon(Icons.visibility,
                                                  color: Colors.green),
                                        ),
                                      ],
                                    ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.lightGreen,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              '회원가입',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            padding: EdgeInsets.all(15),
                            onPressed: () async {
                              _tryValidation();
                              //* 사용자 등록 과정.
                              //* 정보를 담는 시도를 하고
                              //* 오류가 나는 정보에 대해서는 예외적으로 처리해준다.
                              //* try~catch 구문을 활용해서 예외 처리를 해준다.
                              try {
                                final newUser = await _authentication
                                    .createUserWithEmailAndPassword(
                                        email: signEmail,
                                        password: signPassword);
                                if (newUser.user != null) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return LoginPage(
                                      userRepository: _userRepository,
                                    );
                                  }));
                                  //* 페이지를 이동시키고 정상적으로 로그아웃 시킨다.
                                  _authentication.signOut();
                                }
                              } on FirebaseAuthException catch (e) {
                                switch (e.code) {
                                  case "ERROR_WEAK_PASSWORD":
                                    errorMessage = "비밀번호의 보안이 약합니다.";
                                    break;
                                  case "ERROR_INVALID_EMAIL":
                                    errorMessage = "이메일이 올바르지 않습니다.";
                                    break;
                                  case "ERROR_EMAIL_ALREADY_IN_USE":
                                    errorMessage = "이메일이 이미 다른 계정에서 사용 중입니다.";
                                    break;
                                  default:
                                    errorMessage = "정의되지 않은 오류가 발생했습니다.";
                                }
                              }
                            },
                          ),
                        ),
                        TextButton(
                          child: Text(
                            '로그인페이지',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LoginPage(
                                userRepository: _userRepository,
                              );
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
