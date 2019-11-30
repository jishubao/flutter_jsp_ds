import 'package:flutter/material.dart';
import '../service/service_,method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/category_list.dart';
import '../model/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategory(),
            Column(
              children: <Widget>[
                RightTabs(),
                Expanded(
                  child: CategoryGoodsList(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航
class LeftCategory extends StatefulWidget {
  @override
  _LeftCategoryState createState() => _LeftCategoryState();
}

class _LeftCategoryState extends State<LeftCategory> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInWell(index);
        },
      ),
    );
  }

  Widget _leftInWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        var category = list[index].mallCategoryId;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, category);
        HandleGetGoodsList.getGoodsList(context, 1);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory', pos: '分类列表').then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  void _getGoodsList({String catgoryId}) async {
    var data = {
      'categoryId': catgoryId == null ? '4' : catgoryId,
      'CategorySubId': '',
      'page': 1,
    };
    await request('getMallGoods',
            formData: data, pos: 'goodList id----$catgoryId')
        .then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);

      Provide.value<CategpryListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}

// 右侧tab
class RightTabs extends StatefulWidget {
  @override
  _RightTabsState createState() => _RightTabsState();
}

class _RightTabsState extends State<RightTabs> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: childCategory.chukdCategriyList.length,
          itemBuilder: (context, index) {
            return _rightInkWell(index, childCategory.chukdCategriyList[index]);
          },
        ),
      );
    });
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).getChildIndex())
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        HandleGetGoodsList.getGoodsList(context, 1);
        // _getGoodsList(item.mallSubId);
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }
}

// 商品列表
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategpryListProvide>(
      builder: (context, child, data) {
        try{
          if(Provide.value<ChildCategory>(context).page == 1){
            scrollController.jumpTo(0.0);
          }
        }catch(e){
          print('进入页面第一次初始化：$e');
        }
        if (data.goodsList.length > 0) {
          return Container(
            width: ScreenUtil().setWidth(570),
            child: EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: false,
                moreInfo: '加载中',
                loadText: '上拉加载',
                loadReadyText: '松开刷新',
                loadingText: '正在加载',
                loadedText: '刷新完成',
                // noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                noMoreText: '刷新完成',
              ),
              child: ListView.builder(
                controller: scrollController,
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(data.goodsList, index);
                },
              ),
              loadMore: () async {
               _getMoreList();
              },
            ),
          );
        } else {
          return Text('暂无数据');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  _getMoreList() async {
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page,
    };
    await request('getMallGoods', formData: data, pos: 'goodList').then(
      (val) {
        var data = json.decode(val.toString());
        CategoryGoodsListModel goodsList =
            CategoryGoodsListModel.fromJson(data);
        if (goodsList.data == null) {
          Fluttertoast.showToast(
            msg: '已经到底了',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.pink,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
        } else {
          Provide.value<CategpryListProvide>(context)
              .getMoreList(goodsList.data);
        }
      },
    );
  }

  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List newList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.only(left: 5.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：¥${newList[index].presentPrice}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
          Text(
            '¥${newList[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _listWidget(List newList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 请求数据
class HandleGetGoodsList {
  static getGoodsList(context, int page) async {
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId ?? '4',
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': page == null ? 1 : page,
    };
    await request('getMallGoods', formData: data, pos: 'goodList').then(
      (val) {
        var data = json.decode(val.toString());
        CategoryGoodsListModel goodsList =
            CategoryGoodsListModel.fromJson(data);
        if (goodsList.data == null) {
          Provide.value<CategpryListProvide>(context).getGoodsList([]);
        } else {
          Provide.value<CategpryListProvide>(context)
              .getGoodsList(goodsList.data);
        }
      },
    );
  }
}
