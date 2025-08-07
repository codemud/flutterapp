import 'package:flutter/material.dart';
import 'package:flutterapp/page/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶部状态栏
      appBar: AppBar(
        title: const Text('登录', style: TextStyle(color: Colors.white)),
        // backgroundColor: Uiconstants.COLOR_PAGE_GREEN, // 这里不设置背景颜色，使用全局主题
      ),
      // 页面主体
      body: Center(
        child: Column(
          children: [
            const Text('登录页'),
            ElevatedButton(
              onPressed: () {
                // 1.普通路由跳转
                // Navigator.push(context, route) === Navigator.of(context).push(route)
                // 这是替换操作，栈操作
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return HomePage();
                //     },
                //   ),
                // );
                // 这是入栈操作，
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return HomePage();
                //     },
                //   ),
                // );
                // 路由传递参数
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage(userName: '张三');
                    },
                  ),
                );
                // 2.命名路由跳转
                // Navigator.pushNamed(context, '/home');
                // Navigator.pushReplacementNamed(context, '/home'); // 替换操作
                // 路由传递参数
                Navigator.pushNamed(
                  context,
                  '/home',
                  arguments: {'userName': '张三', 'age': 18},
                );
              },
              child: const Text('登录'),
            ),
          ],
        ),
      ),
    );
  }
}
