import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HomeOptions { nearByPolice, emergencyContacts, accountSettings, logout }

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PopupMenuItem<HomeOptions>> _popupMenus;
  List<Widget> _actionButtons;
  void _selectOption(HomeOptions option) {
    switch (option) {
      case HomeOptions.nearByPolice:
        Navigator.pushNamed(context, 'hi');
        break;
      case HomeOptions.emergencyContacts:
        Navigator.pushNamed(context, 'hi');
        break;
      case HomeOptions.accountSettings:
        Navigator.pushNamed(context, 'hi');
        break;
      case HomeOptions.logout:
        Navigator.pushNamed(context, 'hi');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _actionButtons = <Widget>[
      PopupMenuButton<HomeOptions>(
        tooltip: "More options",
        onSelected: _selectOption,
        itemBuilder: (BuildContext context) {
          return _popupMenus;
        },
      ),
    ];

    _popupMenus = [
      PopupMenuItem<HomeOptions>(
        child: Text("Nearby Police"),
        value: HomeOptions.nearByPolice,
      ),
      PopupMenuItem<HomeOptions>(
        child: Text("Emergency Contacts"),
        value: HomeOptions.emergencyContacts,
      ),
      PopupMenuItem<HomeOptions>(
        child: Text("Account Settings"),
        value: HomeOptions.accountSettings,
      ),
      PopupMenuItem<HomeOptions>(
        child: Text("Logout"),
        value: HomeOptions.logout,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('WOMEN SAFETY'), actions: _actionButtons),
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
