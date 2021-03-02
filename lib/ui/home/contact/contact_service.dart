import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/ContactModel.dart';

class ContactService {

  final contactCollection = FirebaseFirestore.instance.collection("contactCollection");


  addContact(ContactModel contactModel){
    contactModel.isDeleted = false;
    this.contactCollection.add(contactModel.toJson()).then((doc) {
      print(doc);
      print("guarde mi contacto");
    });


  }

  updateContact(context, ContactModel contactModel){

  }

  deleteContact(){

  }
}