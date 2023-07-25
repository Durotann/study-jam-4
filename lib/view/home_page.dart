import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import '../domain/service/service.dart';
import '../domain/widgets/circleanim.dart';
import '../domain/widgets/erroranim.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String? pred;
  bool tog = true;

  final double _startWidth = 40.0;
  final double _endWidth = 200.0;
  bool _isExpanded = false;

  bool isTextVisible = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _controller1;
  late Animation<double> _animation1;

  final double _startPosition = 55.0;
  final double _endPosition = 100.0;
  double _currentPosition = 100.0;
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        getHttp();
        showText();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    _controller1 = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation1 = Tween<double>(
      begin: _startWidth,
      end: _endWidth,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeInOut,
    ));

    _controller1
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);

//в

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: _startPosition,
      end: _endPosition,
    ).animate(_controller)
      ..addListener(() {
        setState(() {
          _currentPosition = _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller.dispose();
    super.dispose();
  }

  void showText() {
    setState(() {
      isTextVisible = true;
      tog = false;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isTextVisible = false;
        pred = null;
        tog = true;
      });
    });
  }

  Future<void> getHttp() async {
    final response = await Dio().get('https://www.eightballapi.com/api');
    pred = response.data['reading'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(16, 12, 44, 1), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 500,
                child: MaterialButton(
                  onPressed: () {
                    getHttp();
                    showText();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.only(top: _animation.value),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('image/Mask group.png'),
                        AnimCircle(togl: tog),
                        Center(
                          child: isTextVisible && pred != null
                              ? Text(
                                  pred!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w400),
                                )
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                width: _animation1.value,
                height: 49,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      offset: Offset(10, 10),
                      blurRadius: 60.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "Нажмите на шарн",
                style: TextStyle(color: Color.fromRGBO(114, 114, 114, 1)),
              ),
              Text(
                "или потрясите телефон",
                style: TextStyle(color: Color.fromRGBO(114, 114, 114, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
