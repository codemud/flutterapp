import 'package:flutter/material.dart';
import 'package:flutterapp/constants/UIConstants.dart';

class HomePage extends StatefulWidget {
  String userName; // 路由传递过来的参数 // 这是普通路由传递参数的方式
  HomePage({super.key, this.userName = ''});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // 通过modalRoute获取命名路由传递过来的参数
    var args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      // 顶部状态栏
      appBar: AppBar(
        title: const Text('首页', style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false, // 是否显示返回图标（即标题左侧的）
        leading: Icon(Icons.home, color: Colors.white), // 自定义返回图标
        // backgroundColor: Uiconstants.COLOR_PAGE_GREEN, // 这里不设置背景颜色，使用全局主题
      ),
      // 页面主体
      body: Center(
        child: Column(
          children: [
            Text('社区主页-${widget.userName}'), // 这是普通路由拿到参数的方式
            Text('社区主页-${args?['userName']}'), // 这是命名路由拿到参数的方式
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
