import 'dart:convert';

import 'package:flutter/material.dart'; // 这个库就是谷歌风格的设计UI库
import 'package:flutterapp/constants/UIConstants.dart';
import 'package:flutterapp/constants/api.dart';
import 'package:http/http.dart' as http; // 这个库是用于发送网络请求的

void main() {
  var phoneTextController = TextEditingController(); // 手机号码输入框的控制器

  String phone = ''; // 手机号码的变量
  String password = ''; // 密码的变量
  runApp(
    MaterialApp(
      home: Scaffold(
        // 首页对应的是一个页面脚手架
        backgroundColor: Uiconstants.COLOR_PAGE_BG, // 页面脚手架指定当前页面背景颜色
        // appBar: xxx,            // 页面顶部的状态栏
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              // 可以指定大小的容器
              width: double.infinity, // =100%
              height: double.infinity, // =100%
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/logo.png',
                    width: 240,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20, // 设置组件之间的间距
                  ),
                  TextField(
                    controller: phoneTextController, // 绑定输入框的控制器
                    decoration: InputDecoration(
                      hintText: '请输入手机号码', // 类似于 HTML input 的 placeholder 属性
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      filled: true, // 是否填充背景色,设置了这个属性后，fillColor 才会生效
                      fillColor: Color(0xfff0f0f0), // 输入框的背景颜色
                      // icon: Icon(
                      //   Icons.phone_android_outlined,
                      //   color: Uiconstants.COLOR_PAGE_BLUE,
                      // ), // 这里的 icon 是输入框外部左侧的图标
                      prefixIcon: Icon(
                        Icons.phone_android_sharp,
                        color: Uiconstants.COLOR_PAGE_GREEN,
                      ), // 前缀图标
                      // suffixIcon: Icon(
                      //   Icons.cancel,
                      //   color: Uiconstants.COLOR_PAGE_BLUE,
                      // ), // 后缀图标
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Uiconstants.COLOR_PAGE_BLUE,
                        ),
                        onPressed: () =>
                            phoneTextController.clear(), // 点击清除按钮时清空输入框内容
                      ),
                    ),
                    onChanged: (value) => phone = value,
                  ),
                  SizedBox(
                    height: 20, // 设置组件之间的间距
                  ),
                  // 自定义密码状态组件
                  PwdCustomer(
                    onChanged: (value) => password = value,
                    placeholder: '请输入密码',
                  ),
                  SizedBox(
                    height: 30, // 设置组件之间的间距
                  ),
                  SizedBox(
                    width: double.infinity, // 按钮宽度占满父容器
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // 这里可以添加登录逻辑，比如验证手机号和密码
                        if (phone.isEmpty || password.isEmpty) {
                          print('请输入手机号码和密码');
                        } else {
                          http
                              .post(
                                Uri.parse(ApiConstants.LOGIN),
                                headers: {'Content-Type': 'application/json'},
                                body: jsonEncode({
                                  'phone': phone,
                                  'pwd': password,
                                }),
                              )
                              .then((response) {
                                if (response.statusCode == 200) {
                                  print('登录成功');
                                } else {
                                  print('登录失败');
                                }
                              })
                              .catchError((error) {
                                print('网络请求错误: $error');
                              });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Uiconstants.COLOR_PAGE_GREEN,
                      ),
                      child: Text(
                        '登录',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10, // 设置组件之间的间距
                  ),
                  TextButton(
                    onPressed: () => print('忘记密码'),
                    child: Text(
                      '忘记密码',
                      style: TextStyle(color: Uiconstants.COLOR_PAGE_BLUE),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), // 页面主体内容
        // bottomNavigationBar: xxx, // 页面底部的导航栏
      ),
    ),
  );
}

// 有状态组件
class PwdCustomer extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String placeholder;

  const PwdCustomer({
    super.key,
    required this.onChanged,
    required this.placeholder,
  });

  @override
  State<PwdCustomer> createState() => _PwdCustomerState();
}

class _PwdCustomerState extends State<PwdCustomer> {
  bool isPwdVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPwdVisible, // 是否隐藏文本（密码输入框）
      decoration: InputDecoration(
        hintText: widget.placeholder,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        filled: true,
        fillColor: Color(0xfff0f0f0),
        prefixIcon: Icon(Icons.lock, color: Uiconstants.COLOR_PAGE_GREEN),
        suffixIcon: IconButton(
          icon: Icon(
            isPwdVisible ? Icons.remove_red_eye_sharp : Icons.visibility_off,
            color: Uiconstants.COLOR_PAGE_BLUE,
          ),
          onPressed: () {
            setState(() => isPwdVisible = !isPwdVisible);
          },
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
