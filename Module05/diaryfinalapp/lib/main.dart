import 'package:diaryapp/providers/notes_provider.dart';
import 'package:diaryapp/providers/storage_service_provider.dart';
import 'package:diaryapp/providers/user_provider.dart';
import 'package:diaryapp/screens/agenda_screen.dart';
import 'package:diaryapp/screens/home_screen.dart';
import 'package:diaryapp/screens/login_screen.dart';
import 'package:diaryapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => StorageServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NotesProvider(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'montserrat',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(46, 86, 180, 1),
            ),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          routes: {
            'login': (context) => const LoginScreen(),
            'home': (context) => const HomeScreen(),
            'agenda': (context) => const AgendaScreen(),
            'splash': (context) => const SplashScreen(),
          }),
    );
  }
}
