import 'package:flutter/material.dart';

class ErrorCircle extends StatelessWidget {
  final bool togl;
  const ErrorCircle({super.key, required this.togl});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      alignment: Alignment.center,
      width: togl ? 1 : 380,
      height: togl ? 1 : 380,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Color.fromRGBO(255, 0, 0, 0.5),
              Color.fromRGBO(231, 21, 21, 0.1)
            ],
            stops: [0.6, 3.0],
            center: Alignment.center,
          ),
        ),
      ),
    );
  }
}
