import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/router/fade_route.dart';
import 'package:todo/screen/home_screen.dart';
import 'package:todo/shared/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Navigator.of(context).pushReplacement(
              FadeRoute(
                route: const HomeScreen(),
                page: Container(),
              ),
            );
            Timer(
              const Duration(milliseconds: 300),
              () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(seconds: 2),
              opacity: _opacity,
              child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 3),
                height: _value ? height * 0.15 : height * 0.25,
                width: _value ? width * 0.15 : height * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(.2),
                      blurRadius: height * 0.015,
                      spreadRadius: height * 0.015,
                    ),
                  ],
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Stack(children: [
                    Container(
                      width: width * 0.25,
                      height: height * 0.25,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: AnimatedBuilder(
                        animation: scaleAnimation,
                        builder: (c, child) => Transform.scale(
                          scale: scaleAnimation.value,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: height * 0.04,
                        ),
                        ClipOval(
                          child: SvgPicture.asset(
                            'assets/todo_splash_screen.svg',
                            width: width * 0.112,
                            height: height * 0.112,
                          ),
                        ),
                        Text(
                          "TODO App",
                          style: TextStyle(
                            fontFamily: 'IndieFlower',
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
