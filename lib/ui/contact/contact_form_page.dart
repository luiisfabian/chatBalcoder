import 'package:chat_balcoder/ui/contact/contact_service.dart';
import 'package:chat_balcoder/ui/contact/model/ContactModel.dart';
import 'package:flutter/material.dart';

class ContactFormPage extends StatefulWidget {
  ContactFormPage({this.contactList, this.currentIndex});

  List<ContactModel> contactList;
  int currentIndex;
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  TextEditingController _cContactName = new TextEditingController();
  TextEditingController _cPhoneNumber = new TextEditingController();

  ContactModel _contactModel = new ContactModel();
  ContactService _contactService = new ContactService();

  List<ContactModel> _contactList = [];

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Form Page"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 12.0, right: 12.0, bottom: 12.0),
          child: TextFormField(
            controller: _cContactName,
            decoration: InputDecoration(
              icon: Icon(Icons.face),
              hintText: "Ingrese su nombre",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 12.0, right: 12.0, bottom: 12.0),
          child: TextFormField(
            controller: _cPhoneNumber,
            decoration: InputDecoration(
              icon: Icon(Icons.phone),
              hintText: "Ingrese su número",
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("LO UNDIMOS");

            print(_cContactName.text);
            print(_cPhoneNumber.text);

            _contactModel.contactName = _cContactName.text;
            _contactModel.phoneNumber = _cPhoneNumber.text;
            // _contactModel.phoneNumber = int.parse(_cPhoneNumber.text);

            setState(() {
              _contactList.add(_contactModel);

              _contactService.addContact(_contactModel);
            });

            _contactModel = new ContactModel();
            _cContactName.text = "";
            _cPhoneNumber.text = "";
          },
          child: Container(
            height: _height * 0.05,
            width: _width * 0.24,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(
                "GUARDAR",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            height: _height * 0.45,
            width: _width * 0.90,
            color: Colors.white,
            child: ListView.builder(
              itemCount: _contactList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_contactList[index].contactName),
                  subtitle: Text(_contactList[index].phoneNumber.toString()),
                  leading: Icon(Icons.face_outlined),
                  trailing: Icon(Icons.delete),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
