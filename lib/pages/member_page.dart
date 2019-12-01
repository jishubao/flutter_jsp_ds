import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatefulWidget {
  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _tapHead(),
          SizedBox(height: 15),
          _orders(),
          _orderList(),
          SizedBox(height: 15),
          _orders(),
          _orders(),
          _orders(),
          _orders(),
        ],
      ),
    );
  }

  Widget _tapHead() {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'http://blogimages.jspang.com/blogtouxiang1.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              '啊啊啊',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _orders() {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.delete_outline),
        title: Text('我的订单'),
        trailing: Icon(Icons.delete_outline),
      ),
    );
  }

  Widget _orderList() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[Icon(Icons.delete_outline), Text('我的订单')],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[Icon(Icons.delete_outline), Text('我的订单')],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[Icon(Icons.delete_outline), Text('我的订单')],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[Icon(Icons.delete_outline), Text('我的订单')],
            ),
          ),
        ],
      ),
    );
  }
}
