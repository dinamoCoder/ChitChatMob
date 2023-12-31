import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.message, this.onTap,this.color});
  final String? message;
  final Widget? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (e) => onTap!));
      },
      child: Container(
        padding: const EdgeInsets.all(28.5),
        decoration:  BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(50))),
        child: Text(
          message!,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
