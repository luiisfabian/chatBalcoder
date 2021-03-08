import 'package:chat_balcoder/ui/chat/chat_service.dart';
import 'package:chat_balcoder/ui/chat/model/ChatModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatFormPage extends StatefulWidget {
  @override
  _ChatFormPageState createState() => _ChatFormPageState();
}

class _ChatFormPageState extends State<ChatFormPage> {
  ChatServices _chatServices = new ChatServices();
  List<ChatModel> _chatList = [];
  TextEditingController _cMessage = TextEditingController();
  final _listViewController = ScrollController();
  String myUID = "4444";

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
        ),
        body: Column(
          children: [
            Container(
              height: _height * 0.75,
              color: Colors.white30,
              child: StreamBuilder(
                stream: _chatServices.chatCollection.orderBy("createdDate", descending: false).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());

                      break;
                    default:
                      _chatList = [];
                      snapshot.data.docs.forEach((doc) {
                        // print(doc.data());
                        _chatList.add(ChatModel.fromSnapShot(doc));
                      });

                      Future.delayed(const Duration(milliseconds: 100), (){
                        _listViewController.animateTo(
                          _listViewController.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn
                        );
                      });
          
                      // return ListView.builder(
                      //   itemBuilder:
                      // }

                      return ListView.builder(
                        itemCount: _chatList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: _width * 0.1,
                              height: _height * 0.1,
                              decoration: BoxDecoration(
                                color: _chatList[index].sendToUID == myUID 
                                ? Colors.purple[200] 
                                : Colors.green[200],
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(10),

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _chatList[index].message,
                                  style: TextStyle(
                                    color: Colors.black,

                                  ),
                                  ),
                              ),
                            ),
                          );
                        
                        },
                      );
                  }
                },
              ),
            ),
            Container(
              height: _height * 0.15,
              color: Colors.black26,
              child: Row(
                children: [
                  Container(
                    width: _width * 0.8,
                    height: _height * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: TextFormField(
                        controller: _cMessage,
                        decoration: InputDecoration(
                          labelText: "Mensaje",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: _width * 0.2,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        ChatModel _chatModel = new ChatModel();
                        _chatModel.message = _cMessage.text;
                        _chatModel.sendToUID = "2312";
                        _chatModel.uid = "333";
                        _chatModel.createdDate = Timestamp.now();

                        _chatServices.addChat(_chatModel);
                        _cMessage.text = "";
                      },
                      child: Icon(
                        Icons.send,
                        size: 18,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
