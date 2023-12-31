import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadSpinner extends StatelessWidget {
  const LoadSpinner({super.key, this.show = false});
  final bool? show;
  @override
  Widget build(BuildContext context) {
    if (show!) {
      return Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: Colors.orange,
          secondRingColor: const Color(0xFF1A1A3F),
          thirdRingColor: const Color(0xFFEA3799),
          size: 50,
        ),
      );
    }
    return const SizedBox();
  }
}
