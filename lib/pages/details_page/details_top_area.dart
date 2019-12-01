import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTapArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
        if(goodsInfo != null){
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
              ],
            ),
          );
        } else {
          return Text('暂无数据');
        }
      },
    );
  }

  Widget _goodImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号：$num',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }
}
