import 'package:flutter/material.dart';

class AccountSettings extends StatefulWidget {
  static final id = 'account_settings';

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  bool isMaleChecked = false;
  bool isFemaleChecked = false;
  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    TextEditingController _textEditingController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Account Settings'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: _width * 0.01),
            child: Column(
              children: [
                SizedBox(
                  height: _height * 0.1,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/e/ed/Elon_Musk_Royal_Society.jpg'),
                  maxRadius: _height * 0.05,
                ),
                SizedBox(
                  height: _height * 0.07,
                ),
                Text(
                  'Change profile pic',
                  style: TextStyle(
                      fontSize: _height * 0.02,
                      fontWeight: FontWeight.w700,
                      color: Colors.lightBlueAccent),
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.lightBlueAccent,
                  cursorRadius: Radius.circular(3),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name',
                    focusColor: Colors.lightBlueAccent,
                  ),
                ),
                SizedBox(
                  height: _height * 0.04,
                ),
                Container(
                  margin: EdgeInsets.only(right: _width * 0.75),
                  child: Text(
                    'Gender',
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: _height * 0.025),
                  ),
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: _width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMaleChecked = !isMaleChecked;
                          if (isMaleChecked) {
                            isFemaleChecked = false;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                            color: isMaleChecked ? Colors.green : Colors.white),
                        child: isMaleChecked
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Text('Male'),
                    SizedBox(
                      width: _width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFemaleChecked = !isFemaleChecked;
                          if (isFemaleChecked) {
                            isMaleChecked = false;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey),
                            color:
                                isFemaleChecked ? Colors.green : Colors.white),
                        child: isFemaleChecked
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Text('Female'),
                  ],
                ),
                SizedBox(
                  height: _height * 0.1,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.0)),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text('UPDATE'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
