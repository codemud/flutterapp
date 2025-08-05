import 'package:flutter/material.dart';
import 'package:flutterapp/page/lgoin.dart'; // 这个库就是谷歌风格的设计UI库

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LoginPage());
  }
}
