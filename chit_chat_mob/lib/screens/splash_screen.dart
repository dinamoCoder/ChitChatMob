// import 'dart:async';
// import 'package:chit_chat_mob/screens/welcomeScreen.dart';
// import 'package:flutter/material.dart';


// Second way: To create a splash screen . This code is also work.
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Timer(
//     //      const Duration(seconds: 3),
//     //     () => Navigator.pushReplacement(context,
//     //         MaterialPageRoute(builder: (builder) => const WelcomeScreen())));
//     _navigateToNextScreen();
//   }

//   _navigateToNextScreen() async {
//     // Simulate a delay for your splash screen
//     await Future.delayed(const Duration(seconds: 5));

//     // Navigate to your main app screen
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) =>  WelcomeScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Image.asset(
//         'assets/images/chitChatLogo.png',
//         fit: BoxFit.contain,
//         width: double.infinity,
//         height: double.infinity,
//       ),
//     );
//   }
// }
