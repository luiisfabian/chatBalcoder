
import 'package:flutter/material.dart';

import 'contact_service.dart';
import 'model/ContactModel.dart';

class ContactListPage extends StatefulWidget {
  ContactListPage({Key key}) : super(key: key);

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  ContactService _contactService = new ContactService();

  List<ContactModel> _contactList = [];

  @override
  void initState() {
    super.initState();
    // _contactService.addContact(new ContactModel(
    //   contactName: "nombre del contacto",
    // phoneNumber: "4324324",
    // isDeleted: false
    // ));
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: StreamBuilder(
        stream: _contactService.contactCollection
            .where("isDeleted", isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());

              break;
            default:
              snapshot.data.docs.forEach((doc) {
                // print(doc.data());
                _contactList.add(ContactModel.fromSnapShot(doc));
              });

              // return ListView.builder(
              //   itemBuilder:
              // }

              return ListView.builder(
                itemCount: _contactList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      _contactList[index].contactName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
