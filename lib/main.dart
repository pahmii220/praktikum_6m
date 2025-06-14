import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Muhammad Pahmi"),
        ),
        body: Center(
          child: Text("Halo, Selamat Datang di Flutter"),
        ),
      ),
    );
  }
}
