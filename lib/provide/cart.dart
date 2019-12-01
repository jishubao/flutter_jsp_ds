import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cart_info.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double allPrice = 0; // 总价格
  int allGoodsCount = 0; // 商品总数量
  bool isAllcheck = true; // 是否全选中

  save(goodsId, goodName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tenpList = (temp as List).cast();

    var isHave = false;
    int ival = 0;

    allPrice = 0;
    allGoodsCount = 0;

    tenpList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tenpList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if(item['isCheck']){
        allPrice += (cartList[ival].price*cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodName': goodName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tenpList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
      // print(tenpList);

      allPrice += (count*price);
      allGoodsCount += count;
    }

    cartString = json.encode(tenpList).toString();
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    allPrice = 0;
    allGoodsCount = 0;
    print('清空完成'); 
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    if (cartString == null) {
      cartList = [];
    } else {
      cartList = [];
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllcheck = true;
      tempList.forEach((item) {
        cartList.add(CartInfoModel.fromJson(item));
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllcheck = false;
        }
      });
    }
    notifyListeners();
  }

  // 删除单个购车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 改变购物车
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 点击全选按钮
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 商品刷量加减
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
