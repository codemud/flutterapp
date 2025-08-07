import 'package:flutter/material.dart'; // 这个库就是谷歌风格的设计UI库
import 'package:flutterapp/constants/UIConstants.dart';
import 'package:flutterapp/routers.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Uiconstants.COLOR_PAGE_BG, // 设置全局主题背景颜色
        appBarTheme: AppBarTheme(
          backgroundColor: Uiconstants.COLOR_PAGE_GREEN, // 顶部标题栏背景色
          foregroundColor: Colors.white, // 设置全局主题的 AppBar 文字/图标的前景色
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ), // 标题文本的样式设置
          centerTitle: true, // 标题居中
        ), // 设置全局主题的 AppBar 颜色
      ),
      routes: appRoutes,
      initialRoute: '/',
    ),
  );
}
