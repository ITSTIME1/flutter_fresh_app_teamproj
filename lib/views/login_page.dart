import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/data/model/sizeconfigs_page.dart';
import 'package:fresh_app_teamproj/data/model/validator_page.dart';

import 'package:fresh_app_teamproj/views/forgotpassword_page.dart';
import 'package:fresh_app_teamproj/views/teachablemachine_page.dart';
import 'package:fresh_app_teamproj/views/onboarding_page.dart';
import 'package:fresh_app_teamproj/views/signup_page.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /** 'Key'
   * 
   * _forkey 는 즉 flutter 에서는 Key 라는 매개변수를 받을 수 있습니다.
   * 위치를 변경하더라도 Key는 상태정보를 유지합니다.
   * 리스트로 예를 들면 index 0 값과 index 1값의 위치를 바꾼다고 생각하면,
   * index 0 에 저장되어 있는 고유한 정보 그리고 위치는 index 0 만이 갖고 있는건데 버튼 같은거로 클릭했을때
   * 위치가 바뀌게 된다면 index 0 은 사라진다고 본다면 index 1 = index 0 이 되어버립니다. flutter 에서는 이러한 위치 값 즉 '상태값'을 기억하기 위해.
   * Key라는 매개변수를 사용해 상태를 유지합니다.
   */

  /** TextEditingController()
   * 
   * TextEditingController는 텍스트 필드의 값을 직접 핸들링 하기 위해서 사용합니다. 
   * onChange 항목을 구현하여 텍스트 필드의 값의 변화가 발생할때 마다 현재 텍스트를 콘솔에 출력하는 방법도 있지만
   * 위와 같은 방법으로 구현한다면 텍스트 필드의 모든 상태 변화 값들을 직접 핸들링 할 수 있다.
  */

  /** validator_page.dart
   *  validate 유효성 검사를 하는 class CheckValidate를 만들어서 String 값으로 전달 받는 방식으로 구현하였습니다.
   *  이메일과 패스워드 두개를 따로 만들어 클래스에 string
   */

  FocusNode _emailFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  final _authentication = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email = '';
  String password = '';
  bool isPasswordVisible = false;
  bool doRemember = false;

  @override
  void initState() {
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    'lib/images/Loginimg.png',
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
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),

                          SizedBox(height: 24.0),
                          // * email field next aciton
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              focusNode: _emailFocus,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => CheckValidate()
                                  .validateEmail(_emailFocus, value!),
                              onSaved: (value) {
                                email = value!;
                              },
                              onChanged: (value) {
                                email = value;
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
                          SizedBox(
                            height: 10.0,
                          ),
                          // * password field
                          // * passowrd field done

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              focusNode: _passwordFocus,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) => CheckValidate()
                                  .validatePassword(_passwordFocus, value!),
                              onSaved: (value) {
                                password = value!;
                              },
                              onChanged: (value) {
                                password = value;
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
                          Row(
                            children: [
                              Checkbox(
                                value: doRemember,
                                onChanged: (value) {
                                  setState(() {
                                    doRemember = value!;
                                  });
                                },
                              ),
                              Text(
                                "Remember Me",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            width: double.infinity,
                            child: RaisedButton(
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(15),
                              // 눌렀을때 조건에 맞는 validate 값을 상태변환 시켜줌.
                              onPressed: () async {
                                FocusScope.of(context).requestFocus();
                                _tryValidation();
                                //* 로그인 정보를 loginUser 변수에 담고
                                try {
                                  final loginUser = await _authentication
                                      .signInWithEmailAndPassword(
                                          email: email, password: password);
                                  //* 만약 로그인이 성공적으로 로그인이 되었을경우 메인페이지로 이동.
                                  if (loginUser.user != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return TeachableMachine();
                                        },
                                      ),
                                    );
                                    //* 이메일과 패스워드가 잘못되었을때 콘솔에 출력.(test)
                                  }
                                } on FirebaseAuthException catch (e) {
                                  switch (e.code) {
                                    case "ERROR_INVALID_EMAIL":
                                      errorMessage = "이메일 주소의 형식이 잘못되었습니다.";
                                      break;
                                    case "ERROR_WRONG_PASSWORD":
                                      errorMessage = "패스워드가 너무 깁니다.";
                                      break;
                                    case "ERROR_USER_NOT_FOUND":
                                      errorMessage =
                                          "이와 같은 이메일을 가진 사용자는 존재하지 않습니다.";
                                      break;
                                    case "ERROR_USER_DISABLED":
                                      errorMessage =
                                          "이와 같은 이메일을 가진 사용자가 비활성화 되었습니다.";
                                      break;
                                    case "ERROR_TOO_MANY_REQUESTS":
                                      errorMessage =
                                          "요청이 너무 많습니다. 나중에 다시 시도하여 주시기 바랍니다.";
                                      break;
                                    case "ERROR_OPERATION_NOT_ALLOWED":
                                      errorMessage = "이메일 및 비밀번호로 로그인할 수 없습니다.";
                                      break;
                                    default:
                                      errorMessage =
                                          "An undefined Error happened.";
                                  }
                                }
                              },

                              child: Text(
                                '로그인',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 5.0, right: 10.0),
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Text(
                                '또는',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 5.0),
                                  child: Divider(
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('kakaotalk');
                                },
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'lib/images/kakaotalk.png'),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('google');
                                },
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image:
                                          AssetImage('lib/images/google.png'),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('naver');
                                },
                                child: Container(
                                  height: 60.0,
                                  width: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                        blurRadius: 1.0,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage('lib/images/naver.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
