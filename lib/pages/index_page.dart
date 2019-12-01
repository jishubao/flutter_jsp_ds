import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './home_page.dart';
import './cart_page.dart';
import './category_page.dart';
import './member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/current_index.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> buttomBtns = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text('会员中心'),
    ),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: buttomBtns,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}

// class IndexPage extends StatefulWidget {
//   @override
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   final List<BottomNavigationBarItem> buttomBtns = [
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.home),
//       title: Text('首页'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.search),
//       title: Text('分类'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.shopping_cart),
//       title: Text('购物车'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(CupertinoIcons.profile_circled),
//       title: Text('会员中心'),
//     ),
//   ];

//   int currentIndex = 0;
//   // var _controller = PageController(
//   //   initialPage: 0,
//   // );

//   final List<Widget> tabBodies = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     MemberPage(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//     // print('设备项目密度：${ScreenUtil.pixelRatio}');
//     // print('设备高：${ScreenUtil.screenHeight}');
//     // print('设备宽：${ScreenUtil.screenWidth}');

//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       // body: PageView(
//       //   controller: _controller,
//       //   physics: NeverScrollableScrollPhysics(), //禁止滚动
//       //   children: <Widget>[
//       //     HomePage(),
//       //     CategoryPage(),
//       //     CartPage(),
//       //     MemberPage(),
//       //   ],
//       // ),
//       body: IndexedStack(
//         index: currentIndex,
//         children: tabBodies,
//       ),
//       // body: tabBodies[currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: currentIndex,
//         items: buttomBtns,
//         onTap: (index) {
//           // _controller.jumpToPage(index);
//           setState(() {
//             currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
