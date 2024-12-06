import 'package:flutter/material.dart';

// HTTP method package
import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:convert';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มรายการใหม่'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            //ช่องกรอกข้อมูล title
            TextField(
                controller: todo_title, //ดึงตัวแปล todo_title มาใช้
                decoration: InputDecoration(
                    labelText: 'รายการที่ต้องทำ',
                    border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            TextField(
                minLines: 4,
                maxLines: 8,
                controller: todo_detail, //ดึงตัวแปล todo_title มาใช้
                decoration: InputDecoration(
                    labelText: 'รายละเอียด', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            //ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () {
                  print('---------------------------');
                  print('title : ${todo_title.text}');
                  print('detsil : ${todo_detail.text}');
                  postTodo();
                  setState(() {
                    todo_title.clear();
                    todo_detail.clear();
                  });
                },
                child: Text("เพิ่มรายการ"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff00f7ff)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(50, 20, 50, 20)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 30))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future postTodo() async {
    // Future Function ดึงข้อมูลจาก API

    //http://localhost:8000/api/post-todolist
    // var url = Uri.https('48cb-103-10-231-27.ngrok-free.app', '/api/post-todolist');
    var url = Uri.http('172.168.4.185:8000', '/api/post-todolist');
    Map<String, String> header = {"content-type": "application/json"};
    String jsondata =
        '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('-------result------');
    print(response.body);
  }
}
