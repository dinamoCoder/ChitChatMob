// ignore: file_names
import 'package:chit_chat_mob/screens/login.dart';
import 'package:chit_chat_mob/screens/signup.dart';
import 'package:chit_chat_mob/widgets/custom_button.dart';
import 'package:chit_chat_mob/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
      children: [
        Flexible(
            flex: 8,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: [
                      TextSpan(
                          text: "Welcome to the Chit Chat App\n",
                          style: TextStyle(
                              fontSize: 45.0, fontWeight: FontWeight.w600)),
                      TextSpan(
                          text:
                              "\nThis application is for chatting with your friends",
                          style: TextStyle(fontSize: 30.0)),
                    ]),
                  ),
                ))),
        const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  // here expanded take up the entire space i.e:Creates a widget that expands a child of a [Row], [Column],
                  //or [Flex] so that the child fills the available space along the flex widget's main axis.
                  Expanded(
                      child: CustomButton(
                    message: "Login",
                    onTap: Login(),
                    color: Colors.transparent,
                  )),
                  Expanded(
                      child: CustomButton(
                    message: "Sign Up",
                    onTap: Signup(),
                    color: Colors.white,
                  )),
                ],
              ),
            ))
      ],
    ));
  }
}
