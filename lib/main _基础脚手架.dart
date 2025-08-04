import 'package:flutter/material.dart';
import 'package:flutterapp/constants/UIConstants.dart'; // 这个库就是谷歌风格的设计UI库

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        // 首页对应的是一个页面脚手架
        backgroundColor: Uiconstants.COLOR_PAGE_BG, // 页面脚手架指定当前页面背景颜色
        // appBar: xxx,            // 页面顶部的状态栏
        body: Text('hello world'), // 页面主体内容
        // bottomNavigationBar: xxx, // 页面底部的导航栏
      ),
    ),
  );
}
