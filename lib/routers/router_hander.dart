import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

Handler detailsHander = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    String goodsId = params['id'].first;
    // print('details id $goodsId');
    return DetailsPage(goodsId);
  }
);
