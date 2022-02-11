import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:fresh_app_teamproj/bloc/bloc/google_button.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_event.dart';

class LoginPage2 extends StatelessWidget {
  const LoginPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                // [Login Logo Text]
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),

                // [Email TextField]
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 30,
                    right: 30,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // 상태가 없을때 나타나는 문구
                      hintText: '계정(email)',
                    ),
                  ),
                ),

                // [Password TextFiled]
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 30,
                    right: 30,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: '비밀번호 8~15자리',
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),

                // [Login Button Function]
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.height / 12,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {},
                          child: Text(
                            '로그인',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // [회원가입, 비밀번호 찾기]
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '회원가입',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey[500],
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 9),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        '비밀번호찾기',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.grey[500],
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),

                // [Divider Widget]
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 40.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 145,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                      Text(
                        '또는',
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 15.0,
                        ),
                      ),
                      Container(
                        width: 145,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // [KaKaoTalk Button]
                    KaKaoButton(),

                    // [Google Button]
                    GoogleButton(),

                    // [Naver Button]
                    NaverButton(),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 따로 클래스로 뺄 준비

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        width: MediaQuery.of(context).size.height / 11,
        height: MediaQuery.of(context).size.height / 11,
        child: Image(
          image: AssetImage('lib/images/googlelogo.png'),
        ),
      ),
    );
  }
}

class NaverButton extends StatelessWidget {
  const NaverButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height / 11,
      height: MediaQuery.of(context).size.height / 11,
      child: Image(
        image: AssetImage('lib/images/naver.png'),
      ),
    );
  }
}

class KaKaoButton extends StatelessWidget {
  const KaKaoButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height / 11,
      height: MediaQuery.of(context).size.height / 11,
      decoration: BoxDecoration(
        color: Color.fromRGBO(254, 229, 0, 100),
        shape: BoxShape.circle,
      ),
      child: Image(
        image: AssetImage('lib/images/kakaocomment.png'),
      ),
    );
  }
}
