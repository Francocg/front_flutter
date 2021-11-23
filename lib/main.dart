import 'package:flutter/material.dart';
import 'package:front_flutter/editar.dart';
import 'package:front_flutter/home.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/home',
      routes: {
        '/home':(_) => HomePage(),
       
        '/editar':(_) => EditarPage(),
      },
     
    );
  }
}




