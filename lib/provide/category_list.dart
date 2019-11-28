import 'package:flutter/material.dart';
import '../model/category_goods_list.dart';

class CategpryListProvide with ChangeNotifier {
  List<CateGroyListData> goodsList = [];
  
  // 点击大类时 更换商品列表
  getGoodsList(List<CateGroyListData> list){
    goodsList = list;
    notifyListeners();
  }

}