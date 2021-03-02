
import 'package:chat_balcoder/ui/home/contact/contact_list_page.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = new TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff168381),
          centerTitle: false,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(icon: Icon(Icons.messenger_outline_rounded)),
            ],
            indicatorColor: Colors.white,
          ),
          actions: [Padding(
                  padding: const EdgeInsets.only(left: 270.0),
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                  ))],
          title: Row(
            children: [
              Center(child: Text(" SarApp")),
              
            ],
          ),
        ),
        body: Center(
          child: TabBarView(

            children: [
              ContactListPage(),
              Container(color: Colors.blue,)
              
              //1RA PANTALLA
              // ContactListPage(),

              //2DA PANTALLA
              // ChatListPage(),
            ],

            controller: _tabController, //Controlador
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                if (_tabController.index == 0) {
                  // return ContactFormPage();
              } else {
                // return ChatFormPage();
              }
              })
              );
            },
            child: Icon(Icons.add_circle_outline),
            backgroundColor: Color(0xffe6b800)));
  }
}