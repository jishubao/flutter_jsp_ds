import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> chukdCategriyList = [];
  int childIndex = 0; // 子类高亮索引
  
  getChildIndex(){
    return childIndex;
  }

  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list){
    childIndex = 0;

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';
    
    chukdCategriyList = [all];
    chukdCategriyList.addAll(list);
    // 监听更新
    notifyListeners();
  }

  // 子类改变索引
  changeChildIndex(index){
    childIndex = index;
    // 监听更新
    notifyListeners();
  }

}