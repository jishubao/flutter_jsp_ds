import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/child_category.dart';
import './provide/category_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/current_index.dart';
import 'package:fluro/fluro.dart';
import './routers/router.dart';
import './routers/application.dart';

void main() {
  var childCategory = ChildCategory();
  var categpryListProvide = CategpryListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var providers = Providers();
  providers
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(Provider<CategpryListProvide>.value(categpryListProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          primaryColor: Colors.pink,
        ),
        home: IndexPage(),
      ),
    );
  }
}
