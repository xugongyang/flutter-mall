import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xingpin_mall_app/pages/compenents/app_tab_bar.dart';
import 'package:xingpin_mall_app/pages/sub/trade_detail.dart';
import 'package:xingpin_mall_app/pages/sub/trade_list.dart';
import 'package:xingpin_mall_app/pages/sub/search.dart';
import 'package:xingpin_mall_app/router/routers.dart';

/// 路由管理

final _routes = {
  RouterNames.root: (context) => AppTabBar(),
  RouterNames.search: (context,{arguments}) => SearchPage(arguments: arguments),
  RouterNames.tradeList: (context,{arguments}) => TradeListPage(arguments: arguments),
  RouterNames.tradeDetail: (context,{arguments}) => TradeDetailPage(arguments: arguments),
};

// 注册路由
Route _routeGenerator (RouteSettings settings) {
  final String name = settings.name;
  final Function pageBuilder = routes[name];

  // 判断是否传递参数
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      return MaterialPageRoute(builder: (context) => pageBuilder(context, arguments: settings.arguments));
    } else {
      return MaterialPageRoute(builder: (context) => pageBuilder(context));
    }
  }

  return MaterialPageRoute(builder: (context) => routes[RouterNames.root]);
}

get routes => _routes;
get routeGenerator => _routeGenerator;




