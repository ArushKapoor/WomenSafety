import 'package:flutter/material.dart';
import 'package:women_safety/Screens/AudioRecordPage.dart';
import 'package:women_safety/Models/ContactsHandler.dart';
import 'package:women_safety/Screens/AccountSettings.dart';
import 'package:women_safety/Screens/HomePage.dart';
import 'package:women_safety/Screens/SignUpPage.dart';
import 'package:provider/provider.dart';
import 'Screens/EmergencyContacts.dart';
import 'Auth/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authCredentialChanges,
        ),
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
          AccountSettings.id: (context) => AccountSettings(),
          AuthenticationWrapper.id: (context) => AuthenticationWrapper(),
        },
        initialRoute: AuthenticationWrapper.id,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static final id = 'wrapper';
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    User auth = FirebaseAuth.instance.currentUser;
    User userfromPhone = context.watch<AuthenticationService>().user;
    if (user != null && auth.phoneNumber != null && userfromPhone != null) {
      return HomePage();
    } else {
      return SignUpPage();
    }
  }
}
