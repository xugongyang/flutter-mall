
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/pages/main/cart.dart';
import 'package:xingpin_mall_app/pages/main/category.dart';
import 'package:xingpin_mall_app/pages/main/home.dart';
import 'package:xingpin_mall_app/pages/main/mine.dart';
import 'package:xingpin_mall_app/store/app_store.dart';
import 'package:xingpin_mall_app/store/cart_store.dart';
import 'package:xingpin_mall_app/utils/translations.dart';

class AppTabBar extends StatefulWidget {
  final int currentIndex;
  AppTabBar({Key key, this.currentIndex=0}) : super(key: key); // 重新写构造函数

  @override
  State<StatefulWidget> createState() => _AppTabBarState(this.currentIndex);
}

class _AppTabBarState  extends State<AppTabBar>{

  final _defaultColor = Color(0xff999999); // 默认颜色
  Color _activeColor ; // 选中颜色
  int _tabIndex; // tabBar 下标
  final PageController _controller = PageController(initialPage: 0);


  _AppTabBarState(this._tabIndex);

  @override
  void initState() {
    setState(() {
      _activeColor = Provider.of<AppStore>(context,listen: false).primaryColor;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          CategoryPage(),
          CartPage(),
          MinePage()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _tabIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _tabBarItem(Translations.of(context).text('home'),Icons.home,0),
          _tabBarItem(Translations.of(context).text('category'),Icons.category,1),
          _cartBar(),
          _tabBarItem(Translations.of(context).text('mine'),Icons.person,3),
        ],
      ),
    );
  }

  /// 底部tabBar
  _tabBarItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon,color: _defaultColor),
        activeIcon: Icon(icon,color: _activeColor),
        title: Text(title, style: TextStyle(color: _tabIndex == index ? _activeColor : _defaultColor))
    );
  }

  /// 购物车
  _cartBar() {
    int count = Provider.of<CartStore>(context,listen: true).cartList.length;

    if(count < 1){
      return BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart,color: _defaultColor),
          activeIcon: Icon(Icons.shopping_cart,color: _activeColor),
          title: Text(Translations.of(context).text('shopping_cart'), style: TextStyle(color: _tabIndex == 2 ? _activeColor : _defaultColor))
      );
    }

    Text cartText = Text('$count',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(22)));
    if(count > 99){
      cartText = Text('99+',style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(16)));
    }

    return BottomNavigationBarItem(
        icon: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Icon(
                Icons.shopping_cart,
                color: _defaultColor,
                size: ScreenUtil().setSp(48),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              width: ScreenUtil().setSp(36),
              height: ScreenUtil().setSp(36),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(18))
                ),
                child: cartText,
              ),
            )
          ],
        ),
        activeIcon: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Icon(
                Icons.shopping_cart,
                color: _activeColor,
                size: ScreenUtil().setSp(48),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              width: ScreenUtil().setSp(36),
              height: ScreenUtil().setSp(36),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(18))
                ),
                child: cartText,
              ),
            )
          ],
        ),
        title: Text(Translations.of(context).text('shopping_cart'), style: TextStyle(color: _tabIndex == 2 ? _activeColor : _defaultColor))
    );
  }



}

