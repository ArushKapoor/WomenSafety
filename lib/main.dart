import 'package:flutter/material.dart';
import 'package:women_safety/Screens/AudioRecordPage.dart';
import 'package:women_safety/Screens/HomePage.dart';
import 'package:women_safety/Screens/SignUpPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
        AudioRecordPage.id: (context) => AudioRecordPage(),
      },
      initialRoute: AudioRecordPage.id,
    );
  }
}
