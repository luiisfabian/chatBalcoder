import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String key;
  String message;
  String sendToUID;
  String uid;
  Timestamp createdDate;


  ChatModel({
    this.key,
    this.message,
    this.sendToUID,
    this.uid,
    this.createdDate,
  });

  toJson(){
    return {
      "key": key,
      "message": message,
      "sendToUID": sendToUID,
      "uid": uid,
      "createdDate": createdDate
    };
  }

  factory ChatModel.fromSnapShot(DocumentSnapshot snapshot) {
    return ChatModel(
        key: snapshot.id,
        message: snapshot.data()['message'],
        sendToUID: snapshot.data()['sendToUID'],
        uid: snapshot.data()['uid'],
        createdDate: snapshot.data()['createdDate'],
        );
  }
}
