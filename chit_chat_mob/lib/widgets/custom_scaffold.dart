import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // through this we will not show the shadow of appbar in owr scrren
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            //It is strongly recommended that either both the [width] and the [height] be specified,
            //or that the widget be placed in a context that sets tight layout constraints,
            //so that the image does not change size as it loads. Consider using [fit]
            //to adapt the image's rendering to fit the given width and height if the exact
            //image dimensions are not known in advance.
            height: double.infinity,
          ),
          SafeArea(child: child!)
        ],
      ),
    );
  }
}
