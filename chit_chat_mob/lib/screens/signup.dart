import 'package:chit_chat_mob/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      child: Text("sign up screen"),
    );
  }
}
