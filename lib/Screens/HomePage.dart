import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:women_safety/Screens/AccountSettings.dart';
import 'package:women_safety/Screens/EmergencyContacts.dart';
import 'package:women_safety/Widgets/MapBottomSheetBuilder.dart';

enum HomeOptions { nearByPolice, emergencyContacts, accountSettings, logout }

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool recStarted = false;

  @override
  void initState() {
    super.initState();
  }

  ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
    print('The phone is shaking');
  });

  @override
  Widget build(BuildContext context) {
    //recStarted = true;
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    void _selectOption(HomeOptions option) {
      switch (option) {
        case HomeOptions.nearByPolice:
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            elevation: 10,
            enableDrag: true,
            builder: (context) => SingleChildScrollView(
              child: MapBottomSheetBuilder(height: _height, width: _width),
            ),
          );
          break;
        case HomeOptions.emergencyContacts:
          Navigator.pushNamed(context, EmergencyContacts.id);
          break;
        case HomeOptions.accountSettings:
          Navigator.pushNamed(context, AccountSettings.id);
          break;
        case HomeOptions.logout:
          Navigator.pushNamed(context, 'hi');
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('WOMEN SAFETY'),
        actions: [
          PopupMenuButton<HomeOptions>(
            tooltip: "More options",
            onSelected: _selectOption,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<HomeOptions>(
                  child: PopUpItem(
                    height: _height,
                    width: _width,
                    iconName: 'Near By Police',
                    iconUrl: 'assets/icons/police.jpeg',
                  ),
                  value: HomeOptions.nearByPolice,
                ),
                PopupMenuItem<HomeOptions>(
                  child: PopUpItem(
                    height: _height,
                    iconName: 'Emergency Contacts',
                    iconUrl: 'assets/icons/emergencyCall.jpeg',
                    width: _width,
                  ),
                  value: HomeOptions.emergencyContacts,
                ),
                PopupMenuItem<HomeOptions>(
                  child: PopUpItem(
                    height: _height,
                    iconName: 'Account Settings',
                    iconUrl: 'assets/icons/account.jpeg',
                    width: _width,
                  ),
                  value: HomeOptions.accountSettings,
                ),
                PopupMenuItem<HomeOptions>(
                  child: PopUpItem(
                    height: _height,
                    width: _width,
                    iconName: 'Logout',
                    iconUrl: 'assets/icons/logout.jpeg',
                  ),
                  value: HomeOptions.logout,
                ),
              ];
            },
          ),
        ],
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
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        elevation: 10,
                        enableDrag: true,
                        builder: (context) => SingleChildScrollView(
                          child: MapBottomSheetBuilder(
                              height: _height, width: _width),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: 34,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.025,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (recStarted)
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(_height * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                width: _width,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: _width * 0.1, vertical: _height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Please make sure if it really is an emergency!',
                      style: TextStyle(
                          fontSize: _height * 0.028,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: _height * 0.04,
                    ),
                    Icon(
                      Icons.mic,
                      size: _height * 0.09,
                    ),
                    SizedBox(
                      height: _height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'RECORDING AUDIO',
                          style: TextStyle(fontSize: _height * 0.023),
                        ),
                        SizedBox(
                          width: _width * 0.1,
                        ),
                        Text('15s'),
                      ],
                    ),
                    SizedBox(
                      height: _height * 0.04,
                    ),
                    Container(
                      color: Colors.cyan,
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            recStarted = false;
                            print(recStarted);
                          });
                        },
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PopUpItem extends StatelessWidget {
  final double width;
  final double height;
  final String iconUrl;
  final String iconName;
  PopUpItem({this.height, this.width, this.iconName, this.iconUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.5,
      child: Row(
        children: [
          Image(
            image: AssetImage(iconUrl),
            height: height * 0.032,
          ),
          SizedBox(
            width: width * 0.01,
          ),
          Text(iconName)
        ],
      ),
    );
  }
}
