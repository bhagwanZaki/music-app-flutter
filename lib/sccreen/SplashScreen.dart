import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_lyric_app/contants/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500),
        () => Navigator.popAndPushNamed(context, Routes.musiclistRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF5CA00),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/bg1.png"),
              SizedBox(
                height: 30,
              ),
              Text(
                'Music Lyrics App',
                textAlign: TextAlign.center,
                style: GoogleFonts.berkshireSwash(
                  fontSize: 59,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }
}
