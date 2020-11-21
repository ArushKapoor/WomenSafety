import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety/Models/ContactsHandler.dart';
import 'package:women_safety/Widgets/AddingBottomModalSheet.dart';
import 'package:women_safety/Models/Contact.dart';

class EmergencyContacts extends StatefulWidget {
  static final id = 'emergency_contact';
  @override
  _EmergencyContactsState createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  Widget build(BuildContext context) {
    //print(context.watch<ContactsHandler>().contacts.length);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('EmergencyContacts'),
          centerTitle: true,
          actions: [
            if (Provider.of<ContactsHandler>(context).contacts.length < 5)
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
                child: Icon(
                  Icons.add,
                  color: Colors.cyanAccent,
                ),
              ),
          ],
        ),
        body: Container(
          //height: _height * 0.43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: _width * 0.05, vertical: _height * 0.05),
          child: Consumer<ContactsHandler>(
            builder: (context, contactData, child) {
              return ListView.builder(
                itemCount: contactData.contacts.length,
                itemBuilder: (context, index) {
                  return ContactTile(
                    name: contactData.contacts[index].name,
                    phoneNumber: contactData.contacts[index].phoneNumber,
                    sno: index + 1,
                    contact: contactData.contacts[index],
                    height: _height,
                    width: _width,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  ContactTile(
      {this.name,
      this.phoneNumber,
      this.sno,
      this.contact,
      this.height,
      this.width});
  final sno;
  final String name;
  final Contact contact;
  final double height;
  final double width;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$sno.',
            style: TextStyle(fontSize: height * 0.0223),
          ),
          SizedBox(
            width: width * 0.01,
          ),
          Column(
            children: [
              Text(name),
              Text(phoneNumber),
            ],
          ),
          // SizedBox(
          //   width: width * 0.1,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.all(15),
                //splashRadius: 5],
                // iconSize: 20,
                onPressed: () {},
                icon: Icon(
                  Icons.phone,
                ),
                color: Colors.lightGreenAccent,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                ),
                color: Colors.lightBlueAccent,
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ContactsHandler>(context).deleteContact(contact);
                },
                icon: Icon(
                  Icons.remove_circle_outline,
                ),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
