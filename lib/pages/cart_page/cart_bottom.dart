import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Provide<CartProvide>(
        builder: (context, child, val) {
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              gpButton(context),
            ],
          );
        },
      ),
    );
  }

  Widget selectAllBtn(context) {
    bool isAllcheck = Provide.value<CartProvide>(context).isAllcheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllcheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget allPriceArea(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '合计',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  '¥$allPrice',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.pink),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                color: Colors.red,
                fontSize: ScreenUtil().setSp(22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gpButton(context) {
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child:
              Text('结算($allGoodsCount)', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
