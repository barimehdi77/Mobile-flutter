import 'package:diaryapp/models/user_model.dart';
import 'package:diaryapp/providers/storage_service_provider.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:diaryapp/screens/home_screen.dart';
import 'package:diaryapp/screens/login_screen.dart';
import 'package:diaryapp/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final storageService =
          Provider.of<StorageServiceProvider>(context, listen: false)
              .storageService;

      print("token: ");
      var token = await storageService.readSecureData('token');
      print(token != null);
      if (token != null) {
        var username = await storageService.readSecureData('username');
        var email = await storageService.readSecureData('email');
        var profileImage = await storageService.readSecureData('profileImage');
        if (context.mounted) {
          Provider.of<UserProvider>(context, listen: false).setUser =
              UserModel(username!, email!, profileImage!, token);
        }
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('home');
        }
      } else {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('login');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
