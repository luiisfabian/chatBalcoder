import 'package:chat_balcoder/ui/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  
 runApp(MyApp());
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
