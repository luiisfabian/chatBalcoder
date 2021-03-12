import 'dart:developer';

import 'package:flutter/material.dart';

import 'contact_form_page.dart';
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
              _contactList = [];

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
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ContactFormPage(
                              contactModel: _contactList[index]);
                        }));
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.amberAccent,
                        child: Text(
                          _contactList[index].contactName[0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(_contactList[index].contactName),
                      subtitle: Text(_contactList[index].phoneNumber),
                      trailing: GestureDetector(
                          onTap: () {
                            Widget yesButton = FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                                _contactService.deleteContact(_contactList[index]);
                              },
                              child: Text("Si"),
                            );
                            Widget noButton = FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text("No"),
                            );
                            AlertDialog dialog = AlertDialog(
                              title: Text("Deseas Eliminar Este Registro?"),
                              actions: [
                                // ignore: deprecated_member_use
                                yesButton,
                                noButton
                              ],
                            ); 
                            showDialog(context: context, builder: (context){
                             return dialog;
                            });
                          },
                          child: Icon(Icons.delete)),
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

showAlertDialogDelete(BuildContext context) {}
