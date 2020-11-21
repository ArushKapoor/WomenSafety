import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'Contact.dart';

class ContactsHandler extends ChangeNotifier {
  List<Contact> _contacts = [];
  void addContact(String name, String phoneNumber) {
    _contacts.add(Contact(name: name, phoneNumber: phoneNumber));
    notifyListeners();
  }

  void deleteContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  UnmodifiableListView<Contact> get contacts {
    return UnmodifiableListView(_contacts);
  }
}
