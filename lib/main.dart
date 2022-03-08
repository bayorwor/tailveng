import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tailveng/views/auth/login_view.dart';
import 'package:tailveng/views/home_view.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TailVengApp());
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
        fontFamily: "Montserrat",
        appBarTheme: AppBarTheme(
          color: Color(0xFFFC317B),
          elevation: 0,
        ),
      ),
      home: const HomeView(),
    );
  }
}
