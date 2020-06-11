
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/api/trade_api.dart';
import 'package:xingpin_mall_app/common/base_mixin.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/model/trade_model.dart';
import 'package:xingpin_mall_app/pages/widget/loading_container.dart';
import 'package:xingpin_mall_app/pages/widget/mall_icon.dart';
import 'package:xingpin_mall_app/router/routers.dart';
import 'package:xingpin_mall_app/store/app_store.dart';

class TradeTabPage extends StatefulWidget {
  final String code; // 订单分组

  const TradeTabPage({Key key,this.code}) : super(key: key);

  @override
  _TradeTabPageState createState() => _TradeTabPageState();

}

class _TradeTabPageState extends State<TradeTabPage> {
  bool _isLoading = false;
  List<TradeModel> _tradeList = [];
  ScrollController _scrollController = ScrollController();
  bool _pageLoading = true;

  @override
  void initState() {
    initPageData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('order list 加载更多数据');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _pageLoading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView.separated(
            controller: _scrollController,
            itemCount: _tradeList.length + 1,
            separatorBuilder: (context,index){
              return Divider(height: 0.5, color: Color(0xffdddddd));
            },
            itemBuilder: (context,index){
              return index < _tradeList.length ? _tradeItem(_tradeList[index]) : _renderBottom();
            },
          ),
        ),
      ),
    );
  }



  Future<void> _handleRefresh() async{

    await Future.delayed(Duration(seconds: 1));
    print('order list 下拉刷新');
  }

  /// 页面初始化
  void initPageData() {
    TradeApi.tradeList((TradeListModel model){
      if(model.tradeList.length > 0){
        setState(() {
          _tradeList = model.tradeList;
          _pageLoading = false;
        });
      }

    });
  }

  Widget _tradeItem(TradeModel item) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RouterNames.tradeDetail,arguments: {"tradeCode": item.tradeCode});
        },
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(MallIcon.shop, color: Color(0xff000000),size: ScreenUtil().setSp(30),),
                Padding(padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),),
                Expanded(
                  child: Text(item.shopTitle,style: TextStyle(color: Color(0xff000000),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.w500),),
                ),
                Text(item.status,style: TextStyle(color: Provider.of<AppStore>(context).primaryColor),)
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            item.logisticsLatest !=null ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(MallIcon.truck,color: Color(0xff999999),size: ScreenUtil().setSp(30)),
                          Padding(padding: EdgeInsets.only(left: ScreenUtil().setSp(10)),),
                          Text(item.logisticsLatest.text)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 5),),
                      Container(
                        padding: EdgeInsets.only(left: ScreenUtil().setSp(40)),
                        child: Text(BaseMixin.instance.momentFormat(item.logisticsLatest.time),style: TextStyle(color: Color(0xff999999)),),
                      )
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,color: Color(0xff999999))
              ],
            ) : Container(),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: ScreenUtil().setWidth(150),
                  width: ScreenUtil().setWidth(500),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: item.productList.map((ProductModel product){
                      return Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setSp(5)),
                        width: ScreenUtil().setWidth(150),
                        child: Image.network(product.img),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('¥',style: TextStyle(color: Color(0xff000000)),),
                            Text('${item.payAmount}',style: TextStyle(color: Color(0xff000000),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(32)))
                          ],
                        ),
                        Text('共${item.productList.length}件',style: TextStyle(color: Color(0xff999999),fontSize: ScreenUtil().setSp(24)))
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                item.state == 'PAID' ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Provider.of<AppStore>(context).primaryColor, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: Text('查看物流',style: TextStyle(color: Provider.of<AppStore>(context).primaryColor)),
                ): Container(),
                item.state == 'RECIEVE' ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: Text('评价嗮单'),
                ): Container(),
                item.state == 'RECIEVE' ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Provider.of<AppStore>(context).primaryColor, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                  padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: Text('再次购买',style: TextStyle(color: Provider.of<AppStore>(context).primaryColor),),
                ) : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _renderBottom() {
    if(this._isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '努力加载中...',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      );
    } else {
      return Container(
//        padding: EdgeInsets.symmetric(vertical: 15),
//        alignment: Alignment.center,
//        child: Text(
//          '上拉加载更多',
//          style: TextStyle(
//            fontSize: 15,
//            color: Color(0xFF333333),
//          ),
//        ),
      );
    }
  }

}