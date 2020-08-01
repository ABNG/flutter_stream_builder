import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//to create your own stream.
class _MyHomePageState extends State<MyHomePage> {
  Stream<int> numberStream() async* {
    //using generator function we don't need to close the stream.
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: numberStream().map((event) =>
                "number $event"), //where use to apply condition  //map use for conversions
            initialData: 0,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Hey There is some error"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(
                child: Text(
                  "${snapshot.data}",
                  textScaleFactor: 1.5,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
