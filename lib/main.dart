import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailveng/views/measurement.dart';

void main(List<String> args) {
  runApp(TailVengApp());
}

class TailVengApp extends StatelessWidget {
  const TailVengApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TailVeng',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Measurement(),
    );
  }
}
