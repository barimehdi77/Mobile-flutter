import 'package:diaryapp/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class DisplayProfileWidget extends StatelessWidget {
  const DisplayProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserProfileAvatar(
          avatarUrl: userModel.getUser?.profileImage ?? "",
          radius: 50,
          isActivityIndicatorSmall: false,
          avatarBorderData: AvatarBorderData(
            borderColor: Colors.white60,
            borderWidth: 5.0,
          ),
          avatarSplashColor: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Text(
                userModel.getUser?.userName ?? "",
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const Text(
                "77 Note",
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
