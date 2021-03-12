import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/ContactModel.dart';

class ContactService {
  final contactCollection =
      FirebaseFirestore.instance.collection("contactCollection");

  addContact(ContactModel contactModel) {
    contactModel.isDeleted = false;
    this.contactCollection.add(contactModel.toJson()).then((doc) {
      print(doc);
      print("guarde mi contacto");
    });
  }

  updateContact(ContactModel contactModel) {
    contactCollection
        .doc(contactModel.contactKey)
        .update(contactModel.toJson())
        .then((value) {});
  }

 deleteContact(ContactModel contactModel){
    contactModel.isDeleted = true;
    contactCollection.doc(contactModel.contactKey).update(contactModel.toJson()).then((value){});
  }
}
