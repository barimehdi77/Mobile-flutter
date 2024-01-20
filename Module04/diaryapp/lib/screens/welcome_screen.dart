import 'package:diaryapp/models/user_model.dart';
import 'package:diaryapp/providers/storage_service_provider.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:diaryapp/services/login_service.dart';
import 'package:diaryapp/widgets/background_painter_widget.dart';
import 'package:diaryapp/widgets/sized_botton_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                    "Welcome To  Your Diary",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
                      "Login to your account:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBotton(
                      label: "LOGIN",
                      onPressed: () async {
                        // Navigator.of(context).pushReplacementNamed('login');
                        final storageService =
                            Provider.of<StorageServiceProvider>(context,
                                    listen: false)
                                .storageService;

                        var token =
                            await storageService.readSecureData('token');
                        if (token != null) {
                          var username =
                              await storageService.readSecureData('username');
                          var email =
                              await storageService.readSecureData('email');
                          var profileImage = await storageService
                              .readSecureData('profileImage');
                          if (context.mounted) {
                            Provider.of<UserProvider>(context, listen: false)
                                    .setUser =
                                UserModel(
                                    username!, email!, profileImage!, token);
                          }
                          if (context.mounted) {
                            Navigator.of(context).pushReplacementNamed('home');
                          }
                        } else {
                          if (context.mounted) {
                            Navigator.of(context).pushReplacementNamed('login');
                          }
                        }
                      },
                      width: 330,
                      height: 45,
                      backgroundColor: const Color.fromRGBO(46, 86, 180, 1),
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
