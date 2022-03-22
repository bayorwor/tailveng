import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tailveng/views/home_view.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TailVengApp());
}

class TailVengApp extends StatelessWidget {
  const TailVengApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TailVeng",
      theme: ThemeData(
        primaryColor: const Color(0xFFFC317B),
        primarySwatch: Colors.pink,
        fontFamily: "Montserrat",
        appBarTheme: const AppBarTheme(
          color: Color(0xFFFC317B),
          elevation: 0,
        ),
      ),
      home: const HomeView(),
    );
  }
}
