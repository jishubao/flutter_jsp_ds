import 'package:flutter/material.dart';
import 'package:flutter_jsp/provide/details_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailsInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;

    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var isLeft = Provide.value<DetailsInfoProvide>(context).isLeft;
        if (isLeft) {
          return Container(
            child: Html(data: goodsDetails),
          );
        } else {
          return Center(
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }
}
