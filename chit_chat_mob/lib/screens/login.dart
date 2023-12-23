import 'package:chit_chat_mob/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      child: Text("login screen"),
    );
  }
}
