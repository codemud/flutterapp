import 'package:flutter/material.dart';
import 'package:flutterapp/routers.dart'; // 这个库就是谷歌风格的设计UI库

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      initialRoute: '/',
      title: 'Flutter Demo',
      // home: LoginPage(), // 这里就不用了，因为我们使用了命名路由
    );
  }
}
