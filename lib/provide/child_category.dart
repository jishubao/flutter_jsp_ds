import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> chukdCategriyList = [];
  int childIndex = 0; // 子类高亮索引
  String categoryId = '4'; //大类ID
  String subId = ''; // 子类ID
  int page = 1; // 列表页数
  String noMoreText = ''; // 显示没有数据的文字 => 加载提示文字

  getChildIndex() {
    return childIndex;
  }

  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1;
    noMoreText = '';
    childIndex = 0;
    categoryId = id;

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';

    chukdCategriyList = [all];
    chukdCategriyList.addAll(list);
    // 监听更新
    notifyListeners();
  }

  // 子类改变索引
  changeChildIndex(index, String id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    // 监听更新
    notifyListeners();
  }

  // 增加page方法
  addPage(){
    page++;
  }

  // 改变加载提示文字
  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }

}
