import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistitems = ['A', 'B', 'C', 'D'];

  @override
  void initState() {
    // TODO: implement initState   เป็น Funtion ที่รันทุกครั้ง ที่หน้านี้เปิดขึ้นมา
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  //การลิ้งไปหน้าอื่น
                  builder: (context) => AddPage())).then((value) => {
                setState(() {
                  print(value);
                  if (value == 'delete') {
                    final snackBar = SnackBar(
                      content: const Text('ลบรายการเรียบร้อยแล้ว'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  ;
                  getTodolist();
                })
              }); //การลิ้งไปหน้าอื่น
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getTodolist();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.blue,
              ))
        ],
        title: Text('All Todolist'),
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistitems
            .length, //เอาข้อมูลใน List มาโชว์ตามจำนวนข้อมูลที่มีใน List todolistitems
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                  "${todolistitems[index]['title']}"), //เอาข้อมูลใน List มาโชว์
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                              todolistitems[index]['id'],
                              todolistitems[index]['title'],
                              todolistitems[index]['detail'],
                            ))).then((value) => {
                      setState(() {
                        getTodolist();
                      })
                    });
              },
            ),
          );
        });
  }

  Future<void> getTodolist() async {
    // List alltodo = [];
    var url = Uri.http('172.168.4.185:8000', '/api/all-todolist');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes); //ดึงข้อมูลมาเป็นภาษาไทย

    // return result;
    print(result);
    setState(() {
      todolistitems =
          jsonDecode(result); //ใช้ jsonDecode มารับค่า String ใน result
    });
  }
}
