import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_lyric_app/sccreen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
            useMaterial3: true,
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
            primaryTextTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
        darkTheme: ThemeData(
            useMaterial3: true,
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
            primaryTextTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
      home: const SplashScreen(),
    );  
  }
}
