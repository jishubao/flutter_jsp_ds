import 'package:flutter/material.dart';
import '../model/details.dart';
import '../service/service_,method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo;

  bool isLeft = true;
  bool isRight = false;
  // tabbar
  changeLeftAndRigt(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isRight = true;
      isLeft = false;
    }
    notifyListeners();
  }

  // 从后台获取商品数据
  getGoodsInfo(String id) async {
    var formData = {'goodId': id};
    await request('getGoodDetailById', formData: formData, pos: '商品详情页').then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
