import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/guess_name.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GUESS TEACHER',
      theme: ThemeData(
        fontFamily: GoogleFonts.athiti().fontFamily,
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 25.0,
            color: Colors.white,
          ),
          headline3: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
          headline4: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          bodyText1: TextStyle(
            fontSize: 25.0,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 25.0,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //home: const GuessAge(),
      routes: {
        GuessAge.routeName: (context) => const GuessAge(),
        CorrectAnswer.routeName: (context) => const CorrectAnswer(),
      },
      initialRoute: GuessAge.routeName,
    );
  }
}
