import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/Models/ContactsHandler.dart';
import 'package:women_safety/Widgets/AddingBottomModalSheet.dart';

class EmergencyContacts extends StatefulWidget {
  static final id = 'emergency_contact';
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('EmergencyContacts'),
        centerTitle: true,
      ),
      body: Container(
        //height: _height * 0.43,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: _width * 0.05, vertical: _height * 0.05),
        child: Consumer<ContactsHandler>(
          builder: (context, value, child) {
            return ListView(
              children: [
                ContactTile(
                  name: 'Mom',
                  phoneNumber: '1234567890',
                  sno: 1,
                ),
                ContactTile(
                  name: 'Mom',
                  phoneNumber: '1234567890',
                  sno: 1,
                ),
                ContactTile(
                  name: 'Mom',
                  phoneNumber: '1234567890',
                  sno: 1,
                ),
                ContactTile(
                  name: 'Mom',
                  phoneNumber: '1234567890',
                  sno: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          elevation: 10,
                          enableDrag: true,
                          builder: (context) => AddingBottomSheetBuilder(
                            height: _height,
                            width: _width,
                          ),
                        );
                      },
                      child: Text('Add'),
                      color: Colors.cyanAccent,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  ContactTile({this.name, this.phoneNumber, this.sno});
  final sno;
  final String name;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$sno .'),
          Column(
            children: [
              Text(name),
              Text(phoneNumber),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Icon(
            Icons.phone,
            color: Colors.lightGreenAccent,
          ),
          Icon(
            Icons.message,
            color: Colors.lightBlueAccent,
          ),
          Icon(
            Icons.remove_circle_outline,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
