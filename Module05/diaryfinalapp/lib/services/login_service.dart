import 'package:diaryapp/models/storage_item_model.dart';
import 'package:diaryapp/models/user_model.dart';
import 'package:diaryapp/providers/storage_service_provider.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginService {
  LoginService();

  Future<UserModel> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    final userData =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return UserModel(
      userData.user!.displayName!,
      userData.user!.email!,
      userData.user!.photoURL!,
      userData.credential!.accessToken!,
    );
  }

  Future<UserModel?> loginWithGithub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: dotenv.env['GITHUB_CLINET_ID'] ?? "",
      clientSecret: dotenv.env['GITHUB_CLIENT_SECRET'] ?? "",
      redirectUrl: dotenv.env['GITHUB_REDIRECT_URL'] ?? "",
    );
    var result = await gitHubSignIn.signIn(context);
    if (result.status == GitHubSignInResultStatus.ok) {
      // Create a new credential
      final credential = GithubAuthProvider.credential(result.token!);
      // Once signed in, return the UserCredential
      final userData =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return UserModel(
        userData.user!.displayName!,
        userData.user!.email!,
        userData.user!.photoURL!,
        userData.credential!.accessToken!,
      );
    } else {
      return null;
    }
  }

  void loginWith(String provider, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          const Center(child: CircularProgressIndicator()),
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final storageService =
        Provider.of<StorageServiceProvider>(context, listen: false)
            .storageService;
    try {
      if (provider == 'GOOGLE') {
        userProvider.setUser = await loginWithGoogle();
      } else {
        userProvider.setUser = await loginWithGithub(context);
      }
      final StorageItemModel token =
          StorageItemModel('token', userProvider.getUser!.token);
      final StorageItemModel username =
          StorageItemModel("username", userProvider.getUser!.userName);
      final StorageItemModel email =
          StorageItemModel("email", userProvider.getUser!.email);
      final StorageItemModel profileImage =
          StorageItemModel("profileImage", userProvider.getUser!.profileImage);

      await storageService.writeSecureData(token);
      await storageService.writeSecureData(username);
      await storageService.writeSecureData(email);
      await storageService.writeSecureData(profileImage);
      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('home');
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
