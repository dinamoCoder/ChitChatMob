import 'package:chit_chat_mob/Services/login_register_service.dart';
import 'package:chit_chat_mob/screens/dashboard_screen.dart';
import 'package:chit_chat_mob/screens/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // First Way: To display the splash screen using the flutter_native_splash package.
  // Documentation link is: https://pub.dev/packages/flutter_native_splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      //     useMaterial3: true),
      home: FutureBuilder(
        future: LoginRegisterService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return snapshot.data == true
                ?  DashboardScreen(message: "",)
                : const WelcomeScreen();
          }
        },
      ),
      //home: WelcomeScreen() //SplashScreen(),
      //home: WelcomeScreen(),
    );
  }
}
