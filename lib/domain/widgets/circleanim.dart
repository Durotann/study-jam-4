import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimCircle extends StatelessWidget {
  final bool togl;
  const AnimCircle({super.key, required this.togl});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      alignment: Alignment.center,
      width: togl ? 1 : 350,
      height: togl ? 1 : 350,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.black, Colors.transparent],
            stops: [0.6, 1.0],
            center: Alignment.center,
          ),
        ),
      ),
    );
  }
}
