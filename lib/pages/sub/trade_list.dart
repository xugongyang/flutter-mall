
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:xingpin_mall_app/model/mall_model.dart';
import 'package:xingpin_mall_app/pages/widget/trade_tab.dart';
import 'package:xingpin_mall_app/store/app_store.dart';
import 'package:xingpin_mall_app/utils/translations.dart';

class TradeListPage extends StatefulWidget {
  final Map arguments; // 页面传参

  TradeListPage({Key key,this.arguments}) : super(key: key);

  @override
  _TradeListPageState createState() => _TradeListPageState();
}

class _TradeListPageState extends State<TradeListPage> with TickerProviderStateMixin{

  List<TabBarModel> _tabBarList = [];
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).text('trade_list')),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(0),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
//              labelPadding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              indicator: UnderlineIndicator(
                  strokeCap: StrokeCap.round,
                  borderSide: BorderSide(
                    color: Provider.of<AppStore>(context,listen: false).primaryColor,
                    width: 3,
                  ),
                  insets: EdgeInsets.only(bottom: 8)
              ),
              tabs: _tabBarList.map<Tab>((TabBarModel tab){
                return Tab(
                  text: tab.name,
                );
              }).toList(),
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: _tabBarList.map((TabBarModel tab){
                return TradeTabPage(code: tab.code);
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 0,vsync: this);

    super.initState();
    this.initPageData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// 页面数据初始化
  void initPageData() {
    print(widget.arguments); // 页面传参
    setState(() {
      _tabBarList = [
        TabBarModel('全部', 'ALL'),
        TabBarModel('待付款', 'WAIT_PAY'),
        TabBarModel('待收货', 'WAIT_ARRIVE'),
        TabBarModel('已完成', 'COMPLETE'),
        TabBarModel('已取消', 'CANCEL')
      ];
      _tabController = TabController(length: _tabBarList?.length, vsync: this);
    });
  }


}