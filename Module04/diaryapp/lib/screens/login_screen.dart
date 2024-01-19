import 'package:diaryapp/services/login_service.dart';
import 'package:diaryapp/widgets/background_painter_widget.dart';
import 'package:diaryapp/widgets/sized_botton_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: BackgroundPainterWidget(),
            size: Size.infinite,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Please login to continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                height: 300,
                // width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "How would you like to login ?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBotton.icon(
                      icon: Image.asset(
                        'assets/images/googleIcon.png',
                        width: 30,
                      ),
                      label: "SIGN IN WITH GOOGLE",
                      onPressed: () async {
                        LoginService().loginWith("GOOGLE", context);
                      },
                      width: 330,
                      height: 45,
                      backgroundColor: Colors.white,
                      borderWidth: 1,
                      borderColor: Colors.grey,
                      textColor: Colors.grey.shade700,
                      borderRadius: 8,
                    ),
                    SizedBotton.icon(
                      icon: Image.asset(
                        'assets/images/githubIcon.png',
                        width: 30,
                        color: Colors.white,
                      ),
                      label: "SIGN IN WITH GITHUB",
                      onPressed: () async {
                        LoginService().loginWith("GITHUB", context);
                      },
                      width: 330,
                      height: 45,
                      backgroundColor: Colors.black,
                      borderWidth: 1,
                      borderColor: Colors.grey,
                      textColor: Colors.white,
                      borderRadius: 8,
                    ),
                  ],
                ),
              ),
              const Center(),
            ],
          )
        ],
      ),
    );
  }
}
