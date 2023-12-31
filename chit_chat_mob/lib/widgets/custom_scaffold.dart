import 'dart:ui';

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        // through this we will not show the shadow of appbar in owr scrren
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/chitchat.gif',
            fit: BoxFit.cover,
            width: double.infinity,
            //It is strongly recommended that either both the [width] and the [height] be specified,
            //or that the widget be placed in a context that sets tight layout constraints,
            //so that the image does not change size as it loads. Consider using [fit]
            //to adapt the image's rendering to fit the given width and height if the exact
            //image dimensions are not known in advance.
            height: double.infinity,
          ),
          ClipRect(
            // to set our rectangle clip
            child: BackdropFilter(
              // to set the blur effect
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              // this conatiner will apply the color to the above image
              child: Container(
                color: const Color.fromARGB(255, 130, 139, 132)
                    .withOpacity(0.5), // to give it a nice opacity
              ),
            ),
          ),
          SafeArea(child: child!)
        ],
      ),
    );
  }
}
