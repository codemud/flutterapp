import 'package:flutter/material.dart';
import 'package:flutterapp/constants/UIConstants.dart';

class HomePage extends StatefulWidget {
  String userName; // 路由传递过来的参数
  HomePage({super.key, this.userName = ''});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶部状态栏
      appBar: AppBar(
        title: const Text('首页', style: TextStyle(color: Colors.white)),
        backgroundColor: Uiconstants.COLOR_PAGE_GREEN,
      ),
      // 页面主体
      body: Center(
        child: Column(
          children: [
            Text('社区主页-${widget.userName}'),
            ElevatedButton(
              onPressed: () {
                // 返回上一个页面,根据上下文对象找到到导航器，进行“历史记录栈”出栈操作
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  print('没有上一个页面可以返回');
                }
              },
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}
