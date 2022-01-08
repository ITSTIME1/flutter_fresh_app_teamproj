import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_button.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_state.dart';
import 'package:fresh_app_teamproj/data/model/sizeconfigs_page.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:fresh_app_teamproj/views/teachablemachine_page.dart';
import 'register_bloc.dart';

// [SignUp Page] //

// 회원가입 페이지 => [UserRepository] Class를 가지고 옵니다.
// UserRepository Class 내부에 있는 [FirebaseAuth] 인스턴스를 사용하기 위함입니다.
// FLow => 이메일, 패스워드는 입력시 Validators의 유효성검사를 거친뒤에 회원가입을 누르게되면
// RegisterSubmitted 함수가 발동되면서 그 안에 email, password 값을 전달하게 됩니다
// 이 값은 이벤트를 핸들하는 BLoc로 전달되게 되며 최종적으로 creatuserwithemailandpassword() 메서드로 전달받게 되어
// 회원가입이 이루어집니다.

class SignUpPage extends StatefulWidget {
  final UserRepository _userRepository;

  const SignUpPage({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // [Email, Password Controller handle controller]

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // late => 초기화 시점을 나중으로 미룹니다
  // RegisterBloc 서버 통신은 비동기적으로 작동합니다. 따라서 초기화를 올바르게 할 수 없기에
  // 초기값이 설정될때까지는 'null'값을 가지고 있다가 값이 초기화가 되는 순간 nonullable로 변합니다.
  late RegisterBloc _registerBloc;

  UserRepository get _userRepository => widget._userRepository;

  // [Register Button Enabled]
  // _emailController & _passwordController 의 .text 값 즉 TextEditingController() 위젯은
  // String? 값을 기본적으로 요구합니다. 때문에 두개의 텍스트 값이 비어있지 않다면 true 값을 반환합니다.
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnabled(RegisterState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  // [LifeCycle]
  // 초기에 RegisterBloc 값이 참조되어진 BlocProvider를 생성시킵니다.
  // _emailController, _passwordController => addListner를 통해서 상태를 지속적으로 전달받습니다.
  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
  }

  // [dispose]
  // 앱이 종료되는 시점에 _emailController, _passwordController 의 핸들러도 종료시킵니다.
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,

      // [BlocListner] => 상태의 대한 설명을 넣는 부분입니다.
      // 성공,실패,제출중 총 세가지의 상태로 나뉘어집니다.

      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('SignIn Failure'),
                    const Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state.isSubmitting) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Sign In...'),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          } else if (state.isSuccess) {
            Future.delayed(
              const Duration(seconds: 4),
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return BlocProvider<AuthenticationBloc>(
                        create: (context) =>
                            AuthenticationBloc(userRepository: _userRepository),
                        child: TeachableMachine(
                          userRepository: _userRepository,
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
        // [BlocBuilder] => BlocProvider로 제공받고 Builder로 제작합니다.
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Form(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Image.asset(
                        'lib/images/Loginimg.png',
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
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
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextButton(
                                child: Text(
                                  '로그인',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BlocProvider<LoginBloc>(
                                          create: (context) => LoginBloc(
                                              userRepository: _userRepository),
                                          child: LoginPage(
                                            userRepository: _userRepository,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 24.0),

                              // [Email field]

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  validator: (_) {
                                    return !state.isEmailValid
                                        ? 'Invalid Email'
                                        : null;
                                  },
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
                                    labelText: '이메일',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),

                              // [Password field]

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _passwordController,
                                  validator: (_) {
                                    return !state.isPasswordValid
                                        ? 'Invalid password'
                                        : null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: '비밀번호',
                                    labelStyle: const TextStyle(),
                                    suffixIcon: _passwordController.text.isEmpty
                                        ? Container(width: 0)
                                        : IconButton(
                                            icon: Icon(Icons.close,
                                                color: Colors.grey[600]),
                                            onPressed: () => {
                                              _passwordController.clear(),
                                            },
                                          ),
                                  ),
                                ),
                              ),

                              // [Register Button]

                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: RegisterButton(
                                  onPressed: isRegisterButtonEnabled(state)
                                      ? _onRegisterSubmiting
                                      : null,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // 회원가입 버튼을 눌렀을때 실행되는 void 메서드 입니다.
  void _onRegisterSubmiting() {
    _registerBloc.add(
      RegisterSubmitted(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  // 텍스트를 작성할때 상태값을 변경해주고 그 값을 전달해주는 email void 메서드입니다.
  void _onLoginEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  // 텍스트를 작성할때 상태값을 변경해주고 그 값을 전달해주는 password void 메서드입니다.
  void _onLoginPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }
}
