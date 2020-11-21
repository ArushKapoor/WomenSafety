import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/Models/ContactsHandler.dart';

class AddingBottomSheetBuilder extends StatelessWidget {
  final height;
  final width;
  AddingBottomSheetBuilder({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    TextEditingController _phoneNumberController = TextEditingController();
    String newTask;
    TextEditingController _textEditingController;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Contact',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500),
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
              TextField(
                controller: _phoneNumberController,
                autofocus: true,
                textAlign: TextAlign.center,
                cursorColor: Colors.lightBlueAccent,
                cursorRadius: Radius.circular(3),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  focusColor: Colors.lightBlueAccent,
                ),
              ),
              FlatButton(
                onPressed: () {
                  //print(newTask);
                  if (_textEditingController.text != null &&
                      _phoneNumberController.text != null) {
                    Provider.of<ContactsHandler>(context, listen: false)
                        .addContact(_textEditingController.text,
                            _phoneNumberController.text);
                    Navigator.pop(context);
                  }
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
