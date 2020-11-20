import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
    print('The phone is shaking');
  });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('WOMEN SAFETY'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Hi User'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Shake your mobile if you are in danger!'),
                SizedBox(
                  height: 15.0,
                ),
                Image.asset(
                  'assets/icons/phone_hand.png',
                  height: 80,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 40.0,
                    width: _width,
                    color: Color(0xff4a8fed),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                        ),
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          size: 34,
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
