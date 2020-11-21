import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety/Auth/AuthenticationService.dart';
import 'package:women_safety/Widgets/AuthBottomSheetBuilder.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'sign_up_page';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  TabController _tabController;
  final _signupFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();
  bool isMaleChecked = false;
  bool isFemaleChecked = false;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  //TextEditingController _phoneController = TextEditingController();
  Stack createField({double width, double height, String text}) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
          ),
          padding: EdgeInsets.only(bottom: 0.0),
          width: width * 0.8,
          height: height * 0.08,
          child: TextFormField(),
        ),
        Container(
          margin: EdgeInsets.only(left: 15.0),
          color: Colors.white,
          child: Text('$text *'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF0F0F0),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: _width,
              height: _height * 0.45,
              color: Color(0xff4a8fed),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: _height * 0.10,
                  ),
                  Container(
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.white, fontSize: _height * 0.04),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                    ),
                    width: _width * 0.9,
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelStyle: TextStyle(
                              fontSize: _height * 0.025,
                              fontWeight: FontWeight.w600),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'Sign Up',
                            ),
                            Tab(
                              text: 'Log In',
                            ),
                          ],
                        ),
                        // TabBarView(
                        //   controller: _tabController,
                        //   children: [
                        //     Icon(Icons.mail),
                        //     Icon(Icons.ac_unit_outlined)
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                //height: _height * 0.441,
                margin: EdgeInsets.only(
                    top: _height * 0.259, bottom: _height * 0.09),
                padding: EdgeInsets.only(
                    top: _height * 0.015,
                    left: _width * 0.05,
                    right: _width * 0.05),
                width: _width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18.0),
                    bottomRight: Radius.circular(18.0),
                  ),
                ),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Form(
                      key: _signupFormKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            CreateField(
                              width: _width,
                              height: _height,
                              text: 'Username',
                              hinText: 'Jhon Doe',
                              controller: _usernameController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CreateField(
                              width: _width,
                              height: _height,
                              hinText: '+91123456789',
                              text: 'Phone Number',
                              controller: _phoneController,
                            ),
                            SizedBox(
                              height: _height * 0.05,
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
                                        color: isMaleChecked
                                            ? Colors.green
                                            : Colors.white),
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
                                        color: isFemaleChecked
                                            ? Colors.green
                                            : Colors.white),
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
                              height: 30,
                            ),
                            Container(
                              width: _width * 0.7,
                              child: Text(
                                'By pressing \'Submit\' you agree to our terms and conditions',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          CreateField(
                            controller: _phoneController,
                            height: _height,
                            hinText: '+91 123456789',
                            text: 'Phone Number',
                            width: _width,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: MaterialButton(
                      onPressed: () {
                        //print(_phoneLoginController);
                        context
                            .read<AuthenticationService>()
                            .loginUser(_phoneController.text.trim(), context);
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          elevation: 10,
                          enableDrag: true,
                          builder: (context) => AuthBottomSheetBuilder(
                            height: _height,
                            width: _width,
                            phoneNumber: _phoneController.text,
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Color(0xff4A8FED),
                        ),
                        //width: _width * 0.3,
                        padding: EdgeInsets.symmetric(
                            horizontal: _width * 0.1, vertical: _width * 0.03),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                              color: Colors.white, fontSize: _height * 0.02),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.04,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// createField(
//                             width: _width, height: _height, text: 'Username'),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         createField(
//                             width: _width,
//                             height: _height,
//                             text: 'Phone Number'),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         createField(
//                             width: _width, height: _height, text: 'Password'),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         createField(
//                             width: _width,
//                             height: _height,
//                             text: 'Confirm Password'),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           children: <Widget>[
//                             SizedBox(
//                               width: _width * 0.1,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: 5.0),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.grey),
//                               ),
//                               height: 40,
//                               width: 40,
//                             ),
//                             Text('Male'),
//                             SizedBox(
//                               width: _width * 0.1,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(right: 5.0),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 border: Border.all(color: Colors.grey),
//                               ),
//                               height: 40,
//                               width: 40,
//                             ),
//                             Text('Female'),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Container(
//                           width: _width * 0.7,
//                           child: Text(
//                             'By pressing \'Submit\' you agree to our terms and conditions',
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
class CreateField extends StatelessWidget {
  final double height, width;
  final String text, hinText;
  final TextEditingController controller;
  CreateField(
      {this.height, this.width, this.text, this.controller, this.hinText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Colors.black54,
      ),
      cursorColor: Colors.lightBlueAccent,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: hinText,
        labelText: text,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        hintStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
