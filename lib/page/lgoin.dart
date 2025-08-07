import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/constants/UIConstants.dart';
import 'package:flutterapp/constants/api.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var phoneTextController = TextEditingController(); // 手机号码输入框的控制器

  String phone = ''; // 手机号码的变量
  String password = ''; // 密码的变量

  @override
  void initState() {
    super.initState();
    // 如果需要在页面加载时执行一些初始化操作，可以在这里进行，比如给数据初始值，不过输入框是需要使用控制器进行赋值的
    // phoneTextController.text = '1234567890'; // 设置输入框的初始值，这是需要注意这样操作只给了输入框赋值，并没有给 phone 变量赋值，如果需要给 phone 变量赋值，可以后面加上phone= phoneTextController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 首页对应的是一个页面脚手架
      // 页面顶部的状态栏
      appBar: AppBar(
        toolbarHeight: 0, // 设置顶部状态栏高度为0，隐藏标题栏,即不显示标题栏（左侧图标+中间标题+右侧图标）
      ),
      backgroundColor: Uiconstants.COLOR_PAGE_BG, // 页面脚手架指定当前页面背景颜色
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
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
                              final Map<String, dynamic> res = jsonDecode(
                                response.body,
                              );
                              if (response.statusCode == 200 &&
                                  res['code'] == 2000) {
                                print('登录成功');
                                toastification.show(
                                  context: context,
                                  message: '登录成功',
                                  backgroundColor: Uiconstants.COLOR_PAGE_GREEN,
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('登录失败'),
                                    content: Text('请检查您的手机号和密码是否正确。'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(
                                          context,
                                        ).pop(), // 关闭对话框 就是返回历史记录栈中上一个页面
                                        child: Text('确定'),
                                      ),
                                    ],
                                  ),
                                );
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
    );
  }
}

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
