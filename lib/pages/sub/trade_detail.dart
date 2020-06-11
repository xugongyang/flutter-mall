

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/api/trade_api.dart';
import 'package:xingpin_mall_app/common/base_mixin.dart';
import 'package:xingpin_mall_app/model/logistics_model.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/model/trade_model.dart';
import 'package:xingpin_mall_app/pages/widget/loading_container.dart';
import 'package:xingpin_mall_app/pages/widget/mall_icon.dart';
import 'package:xingpin_mall_app/store/app_store.dart';
import 'package:xingpin_mall_app/utils/translations.dart';

class TradeDetailPage extends StatefulWidget {
  final Map arguments; // 页面传参
  TradeDetailPage({Key key,this.arguments}) : super(key: key);

  @override
  _TradeDetailPageState createState() => _TradeDetailPageState();
}

class _TradeDetailPageState extends State<TradeDetailPage> {

  TradeModel _detail = TradeModel();
  bool _loading = true;

  @override
  void initState() {

    this.initPageData();

    super.initState();
  }

  /// 页面初始化
  void initPageData() {
    print('初始化');
//    String code = widget.arguments['tradeCode'];
//    print('code=$code');
    TradeApi.tradeDetail((TradeModel model){
      setState(() {
        print('赋值');
        _detail = model;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('渲染');
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      appBar: AppBar(
        title: Text(Translations.of(context).text('trade_detail')),
        centerTitle: true,
      ),
      body: LoadingContainer(
        isLoading: _loading,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color(0xFF6082EC),Color(0xFF32A0F0)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight
                              )
                          ),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(_detail?.status??'',style: TextStyle(color: Colors.white),),
                              Padding(padding: EdgeInsets.only(bottom: 5),),
                              Text(_detail?.tradeCode??'',style: TextStyle(color: Colors.white))
                            ],
                          )
                      ),
                    )
                  ],
                ),
                /// 最新物流信息
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(MallIcon.truck,color: Color(0xff000000),size: ScreenUtil().setSp(32)),
                                Padding(padding: EdgeInsets.only(left: ScreenUtil().setSp(10)),),
                                Text(_detail.logisticsLatest?.text??'')
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 5),),
                            Container(
                              padding: EdgeInsets.only(left: ScreenUtil().setSp(40)),
                              child: Text(BaseMixin.instance.momentFormat(_detail.logisticsLatest?.time??0)??'',style: TextStyle(color: Color(0xff999999)),),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right,color: Color(0xff999999),)
                    ],
                  ),
                ) ,
                /// 收货地址
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(MallIcon.location,color: Color(0xff000000),size: ScreenUtil().setSp(32)),
                                Padding(padding: EdgeInsets.only(left: ScreenUtil().setSp(10)),),
                                Text(_detail.userInfo?.name??''),
                                Text(_detail.userInfo?.phone??'')
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(left: ScreenUtil().setSp(40)),
                              child: Text(_detail.userInfo?.address??''),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                /// 店铺产品
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(MallIcon.shop,color: Color(0xff000000),size: ScreenUtil().setSp(32),),
                          Padding(padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),),
                          Expanded(
                            child: Text('自在优品 官方旗舰店',style: TextStyle(color: Color(0xff000000),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.w500),),
                          ),
                          Icon(Icons.chevron_right,color:Color(0xff999999))
                        ],
                      ),
                      _detail.productList != null ? Column(
                        children: _detail.productList.map((ProductModel item){return _productItem(item);}).toList(),
                      ) : Container(),
                    ],
                  ),
                ),
                /// 交易单信息
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('订单信息',style: TextStyle(color: Color(0xff000000)),),
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            width: ScreenUtil().setWidth(140),
                            margin: EdgeInsets.only(right: 10),
                            child: Text('商品金额:',style: TextStyle(color: Color(0xff999999)),),
                          ),
                          Text('¥${_detail.payAmount}')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            width: ScreenUtil().setWidth(140),
                            margin: EdgeInsets.only(right: 10),
                            child: Text('折扣金额:',style: TextStyle(color: Color(0xff999999)),),
                          ),
                          Text('¥${_detail.discountAmount}')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            width: ScreenUtil().setWidth(140),
                            margin: EdgeInsets.only(right: 10),
                            child: Text('运费:',style: TextStyle(color: Color(0xff999999)),),
                          ),
                          Text('¥${_detail.freightAmount}')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            width: ScreenUtil().setWidth(140),
                            margin: EdgeInsets.only(right: 10),
                            child: Text('实付金额:',style: TextStyle(color: Color(0xff999999)),),
                          ),
                          Text('¥${_detail.payAmount}')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            width: ScreenUtil().setWidth(140),
                            margin: EdgeInsets.only(right: 10),
                            child: Text('下单时间:',style: TextStyle(color: Color(0xff999999)),),
                          ),
                          Text(BaseMixin.instance.momentFormat(DateTime.now().millisecondsSinceEpoch),style: TextStyle(color: Color(0xff999999)),),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }




  Widget _productItem(ProductModel item) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.network(item.img,width: ScreenUtil().setSp(160),height: ScreenUtil().setSp(160),),
              Padding(padding: EdgeInsets.only(left: 10),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(item.title),
                    ),
                    Row(
                      children: <Widget>[
                        Text('数量 ${item.quantity}',style: TextStyle(color: Color(0xff999999)),),
                        Padding(padding: EdgeInsets.only(right: 20),),
                        Text('${item.sku}',style: TextStyle(color: Color(0xff999999)),),
                      ],
                    ),
                    Text('¥${item.salePrice}',style: TextStyle(color: Color(0xff000000),fontWeight: FontWeight.w500),)
                  ],
                ),
              )
            ],
          ),
          Row(
           children: <Widget>[
             Expanded(
               flex: 1,
               child: Container(),
             ),
             Container(
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 border: Border.all(color: Provider.of<AppStore>(context).primaryColor, width: 1, style: BorderStyle.solid),
                 borderRadius: BorderRadius.circular(20),
               ),
               margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
               padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
               child: Text('申请售后',style: TextStyle(color: Provider.of<AppStore>(context).primaryColor)),
             ),
             Container(
               alignment: Alignment.center,
               decoration: BoxDecoration(
                 border: Border.all(color: Provider.of<AppStore>(context).primaryColor, width: 1, style: BorderStyle.solid),
                 borderRadius: BorderRadius.circular(20),
               ),
               margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
               padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
               child: Text('加购物车',style: TextStyle(color: Provider.of<AppStore>(context).primaryColor)),
             )
           ],
          ),
        ],
      ),
    );
  }





}