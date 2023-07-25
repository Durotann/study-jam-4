import 'package:flutter/material.dart';

class ErrorCircle extends StatelessWidget {
  final bool togl;
  const ErrorCircle({super.key, required this.togl});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      alignment: Alignment.center,
      width: togl ? 1 : 350,
      height: togl ? 1 : 350,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.red.withOpacity(0.5), Colors.red.withOpacity(0.1)],
            stops: [0.6, 1.0],
            center: Alignment.center,
          ),
        ),
      ),
    );
  }
}
