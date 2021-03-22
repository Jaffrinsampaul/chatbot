// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var request = "normal";

  List<Widget> widgets = [];

  void init() {
    widgets = [
      Container(
        // color: Colors.black87,
        color: Colors.grey,
        // height: 50,
        // width: 50,
        child: FlatButton(
          color: Colors.black87,
          onPressed: () async {
            getRobotResponse("My Account balance");
          },
        ),
      ),
      // TextFormField(
      //   decoration: InputDecoration(hintText: "Enter your Quries"),
      // )
    ];
  }

  final messageInsert = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (widgets.isEmpty) init();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            "Hashbot",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      // color: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ".",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("Online"),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .010,
            ),
            Container(
              // color: Colors.black87,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 550.0, left: 10, right: 10),
                      child: Row(children: [
                        TextField(
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(25)),
                            hintText: "Enter Your Queries",
                          ),
                        ),
                        // IconButton(
                        //     icon: Icon(Icons.send),
                        //     onPressed: () {
                        //       if (messageInsert.text.isEmpty) {
                        //         print("Empty Message");
                        //       }else{
                        //         getRobotResponse(messageInsert.text);
                        //       }
                        //     })
                      ]))
                ],
                // children: widgets,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getRobotResponse(String message) async {
    var url = Uri.parse('https://looptune.com/api/hashbot.php');
    var body = {"req": request, "query": message};
    var response = await http.post(
      url,
      body: json.encode(body),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var data = json.decode(response.body);
    print(data["for"]);
    print(data["response"]);
    var widget = Text(
      data["response"],
      style: TextStyle(color: Colors.white),
    );

    setState(() {
      widgets.add(widget);
    });
  }
}
