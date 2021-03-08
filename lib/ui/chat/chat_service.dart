import 'package:chat_balcoder/ui/chat/model/ChatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {

  final chatCollection = FirebaseFirestore.instance.collection("chatCollection");


  addChat(ChatModel chatModel){
    // chatModel.isDeleted = false;
    this.chatCollection.add(chatModel.toJson()).then((doc) {
      
      // doc.key
      print(doc);
      print("guarde mi chat");
    });


  }

  updateContact(context, ChatModel chatModel){

  }

  deleteContact(){

  }
}