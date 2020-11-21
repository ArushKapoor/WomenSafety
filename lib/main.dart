import 'package:flutter/material.dart';
import 'package:women_safety/Models/ContactsHandler.dart';
import 'package:women_safety/Screens/HomePage.dart';
import 'package:women_safety/Screens/SignUpPage.dart';
import 'package:provider/provider.dart';
import 'Screens/EmergencyContacts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ContactsHandler(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          EmergencyContacts.id: (context) => EmergencyContacts(),
          SignUpPage.id: (context) => SignUpPage(),
          HomePage.id: (context) => HomePage(),
        },
        initialRoute: SignUpPage.id,
      ),
    );
  }
}
