
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/pages/compenents/cached_image.dart';
import 'package:xingpin_mall_app/pages/widget/loading_container.dart';
import 'package:xingpin_mall_app/pages/widget/mall_icon.dart';
import 'package:xingpin_mall_app/router/routers.dart';
import 'package:xingpin_mall_app/store/app_store.dart';
import 'package:xingpin_mall_app/store/cart_store.dart';

class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage>{

  List _attentionList = [];
  bool _pageLoading = true;

  @override
  void initState() {
    super.initState();
    initPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: LoadingContainer(
        isLoading: _pageLoading,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              children: <Widget>[
                _accountInfo(),
                _orderWidget(),
              ],
            ),
          ),
        ),
      )
    );
  }

  /// 页面初始化
  void initPageData() {
    setState(() {
      this._attentionList = [
        {'title': '商品关注','count': 7},
        {'title': '店铺关注','count': 11},
        {'title': '收藏','count': 23},
        {'title': '足迹','count': 79}
      ];
      _pageLoading = false;
    });
  }

  /// 用户信息
  _accountInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 40, 15, 15),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/mine.png"),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: (){
                  print('用户设置');
                },
                child: Icon(Icons.settings,color: Color(0xffffffff)),
              ),
              Padding(padding: EdgeInsets.only(right: 20),),
              InkWell(
                onTap: (){
                  print('用户信息');
                },
                child: Icon(Icons.sms,color: Color(0xffffffff)),
              ),
            ],
          ),
          // 用户头像
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                margin: EdgeInsets.only(right: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedImageBox(url: 'https://wx.qlogo.cn/mmopen/vi_32/ib7DHLOriaHEusO4icUsT23q7lXMwzP4Hr6gZhy8OuPpiaBAsricn6b3BL3cFkIh6Z3YsIchiby24oswgGib6r9NBDiaJA/132'),

                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('xugongyang',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.w500),),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text('三星会员',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(28)))
                ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20),),
          // 功能标签
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('7',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.w500),),
                    Padding(padding: EdgeInsets.only(top: 8),),
                    Text('商品关注',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(26)))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('11',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.w500),),
                    Padding(padding: EdgeInsets.only(top: 8),),
                    Text('店铺关注',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(26)))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('23',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.w500),),
                    Padding(padding: EdgeInsets.only(top: 8),),
                    Text('收藏',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(26)))
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text('79',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(28),fontWeight: FontWeight.w500),),
                    Padding(padding: EdgeInsets.only(top: 8),),
                    Text('足迹',style: TextStyle(color: Color(0xffffffff),fontSize: ScreenUtil().setSp(26)))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// 订单信息
 _orderWidget(){

    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                print('待付款');
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(
                          MallIcon.wait_pay,
                          color: Color(0xff777777),
                          size: ScreenUtil().setSp(70),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        width: 20,
                        height: 20,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text('1',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(24))),
                        ),
                      )
                    ],
                  ),
                  Text('待付款',style: TextStyle(color: Color(0xff333333)),)
                ],
              ),

            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                print('待收货');
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(
                          MallIcon.wait_delivery,
                          color: Color(0xff777777),
                          size: ScreenUtil().setSp(70),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        width: 20,
                        height: 20,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text('2',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(24))),
                        ),
                      )
                    ],
                  ),
                  Text('待收货',style: TextStyle(color: Color(0xff333333)),)
                ],
              ),

            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                print('待评价');
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(
                          MallIcon.wait_comment,
                          color: Color(0xff777777),
                          size: ScreenUtil().setSp(70),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        width: 20,
                        height: 20,
                        child: Container(
                          alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)
                            ),
                          child: Text('12',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(24))),
                        ),
                      )
                    ],
                  ),
                  Text('待评价',style: TextStyle(color: Color(0xff333333)),)
                ],
              ),

            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                print('退换/售后');
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(
                          MallIcon.after_sale,
                          color: Color(0xff777777),
                          size: ScreenUtil().setSp(70),
                        ),
                      ),
                    ],
                  ),
                  Text('退换/售后',style: TextStyle(color: Color(0xff333333)),)
                ],
              ),

            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouterNames.tradeList,arguments: {"orderType":"ALL"});
              },
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Icon(
                          MallIcon.order,
                          color: Provider.of<AppStore>(context,listen: false).primaryColor,
                          size: ScreenUtil().setSp(70),
                        ),
                      ),

                    ],
                  ),
                  Text('我的订单',style: TextStyle(color: Color(0xff1429a0)),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
 }




  Future<void> onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
      print('下拉刷新');
    });
  }
}