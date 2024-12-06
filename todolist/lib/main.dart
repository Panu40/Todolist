import 'package:flutter/material.dart';
import 'package:todolist/pages/todolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false, //จุด debug มุมบนขวามือ
      title: "Todolist By Panu",
      home:Todolist(),
    );
  }
}