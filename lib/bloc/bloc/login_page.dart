import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_button.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_state.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_page.dart';
import 'package:fresh_app_teamproj/data/model/sizeconfigs_page.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:fresh_app_teamproj/views/teachablemachine.dart';

// [Login Page]

// 로그인 페이지 => [UserRepository] Class를 가지고 옵니다.
// UserRepository Class 내부에 있는 [FirebaseAuth] 인스턴스를 사용하기 위함입니다.
// FLow => 이메일, 패스워드는 입력시 Validators의 유효성검사를 거친뒤에 로그인버튼을 누르게되면
//  _onSubmiting 함수가 발동되면서 그 안에 email, password 값을 전달하게 됩니다
// 이 값은 이벤트를 핸들하는 BLoc로 전달되게 되며 최종적으로 signInWithEmailAndPassword() 메서드로 전달
// 로그인이 이루어집니다.

class LoginPage extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginPage({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Email, password Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  // [Login Button Enabled Logic]
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isLoginButtonEnabled(LoginState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  // * LifeCycle => _loginBloc 에다 BlocProvider를 제공해준다는건 LoginBloc를 사용할 수 있게 한다는 의미.
  // _emailController & _passwordController => addListner 를 통해서 loginBloc에 참조한곳에 있는 LoginEmailChanged 에 입력받은 값을 전달한다.

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onLoginEmailChanged);
    _passwordController.addListener(_onLoginPasswordChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // 상태가 실패했을때.
          // 상태가 실패했을때는 로그인에 실패했을때는 FirebaseException (e)에 의해서 Failure가 발생됨.
          if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('로그인 실패',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const Icon(Icons.error, color: Colors.white)
                  ],
                ),
                backgroundColor: Colors.red[400],
              ),
            );
          }
          // 상태가 제출중일때
          if (state.isSubmitting) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('로그인 진행 중..',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const CircularProgressIndicator(),
                  ],
                ),
                backgroundColor: Colors.orange[400],
              ),
            );
          }
          // 상태값.성공 일때 BLocProvider Ancestor 문제로 context를 위젯트리에서 못찾는 문제가 발생되어.
          // Builder로 감싸 호출 했습니다.
          // Future.delayed 를 통해서 이후에 있을 데이터를 받아온다거나 할때 걸리는 시간을
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('로그인 성공',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const CircularProgressIndicator(),
                  ],
                ),
                backgroundColor: Colors.green,
              ),
            );
            Builder(
              builder: (BuildContext context) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLoggedIn());
                return const CircularProgressIndicator();
              },
            );
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Future.delayed(const Duration(seconds: 3), () {
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
            });
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
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
                                  '회원가입',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 18.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return BlocProvider<RegisterBloc>(
                                          create: (context) => RegisterBloc(
                                              userRepository: _userRepository),
                                          child: SignUpPage(
                                            userRepository: _userRepository,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 24.0),
                              // * email field next aciton
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  validator: (email) {
                                    return !state.isEmailValid
                                        ? 'Invalid Email'
                                        : null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
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
                                    labelText: '이메일',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              // * password field
                              // * passowrd field done

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: _passwordController,
                                  validator: (password) {
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
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 15,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                width: double.infinity,
                                child: LoginButton(
                                  onPressed: isLoginButtonEnabled(state)
                                      ? _onSubmiting
                                      : null,
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 5.0, right: 10.0),
                                      child: const Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const Text(
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
                                      child: const Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: const BoxDecoration(
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
                                    onTap: () {},
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 2),
                                              blurRadius: 2.0),
                                        ],
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'lib/images/google.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: const BoxDecoration(
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
                                          image: AssetImage(
                                              'lib/images/naver.png'),
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
            );
          },
        ),
      ),
    );
  }

  // When use Login button Click to summiting
  void _onSubmiting() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  void _onLoginEmailChanged() {
    _loginBloc.add(LoginEmailChanged(email: _emailController.text));
  }

  void _onLoginPasswordChanged() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }
}
