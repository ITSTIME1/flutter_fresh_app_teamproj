import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/authentication_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_button.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_button.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_event.dart';
import 'package:fresh_app_teamproj/bloc/bloc/register_state.dart';
import 'package:fresh_app_teamproj/data/model/sizeconfigs_page.dart';
import 'package:fresh_app_teamproj/bloc/authentication_event.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

import 'register_bloc.dart';

class SignUpPage extends StatefulWidget {
  final UserRepository _userRepository;

  const SignUpPage({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Email, password Controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  RegisterBloc? _registerBloc;

  UserRepository get _userRepository => widget._userRepository;

  //*로그인 버튼의 활성화 로직.
  // Login button enabled logic
  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  bool isRegisterButtonEnabled(RegisterState state) =>
      state.isFormValid && isPopulated && !state.isSubmitting;

  // * LifeCycle => _loginBloc 에다 BlocProvider를 제공해준다는건 LoginBloc를 사용할 수 있게 한다는 의미.
  // _emailController & _passwordController => addListner 를 통해서 loginBloc에 참조한곳에 있는 LoginEmailChanged 에 입력받은 값을 전달한다.

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
                  children: [
                    const Text('Sign In...'),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          } else if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLoggedIn());
          }
        },
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
                              // * email field next aciton
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailController,
                                  validator: (email) {
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
                              // * password field
                              // * passowrd field done

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
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

  // When use Login button Click to summiting
  void _onRegisterSubmiting() {
    _registerBloc?.add(
      RegisterSubmitted(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  void _onLoginEmailChanged() {
    _registerBloc?.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onLoginPasswordChanged() {
    _registerBloc?.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }
}
