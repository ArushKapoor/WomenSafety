import 'package:flutter/material.dart';
import 'package:women_safety/Screens/HomePage.dart';

class AuthBottomSheetBuilder extends StatelessWidget {
  final double width;
  final double height;
  final String phoneNumber;
  final TextEditingController _textEditingController = TextEditingController();
  AuthBottomSheetBuilder({this.height, this.width, this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    //print(phoneNumber);
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 400,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Container(
                width: width * 0.13,
                height: height * 0.008,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.2),
                child: Text(
                    'Please Enter the 6 digit code we have just send to ******${phoneNumber.substring(7, 10)}'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.3),
                child: TextField(
                  controller: _textEditingController,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                color: Colors.black12,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Color(0xff4A8FED),
                  ),
                  //width: _width * 0.3,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: width * 0.03),
                  child: Text(
                    'SUBMIT',
                    style:
                        TextStyle(color: Colors.white, fontSize: height * 0.02),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
