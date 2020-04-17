import 'package:flutter/material.dart';
import 'package:xianya/mainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,//去掉右上角DEBUG标签
      home: MainPage(),//启动MainPage
    );
  }
}
