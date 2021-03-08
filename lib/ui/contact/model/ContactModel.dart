import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String contactKey;
  String contactName;
  String phoneNumber;
  bool isDeleted;

  ContactModel({
    this.contactKey,
    this.contactName,
    this.phoneNumber,
    this.isDeleted,
  });

  toJson() {
    return {
      "contactName": contactName,
      "phoneNumber": phoneNumber,
      "isDeleted": isDeleted,
    };
  }

  factory ContactModel.fromSnapShot(DocumentSnapshot snapshot){
    return ContactModel(
      contactKey: snapshot.id,
      contactName: snapshot.data()['contactName'],
      phoneNumber: snapshot.data()['phoneNumber'],
      isDeleted: snapshot.data()['isDeleted']
    );
  }
}
