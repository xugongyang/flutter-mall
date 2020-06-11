import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:xingpin_mall_app/api/home_api.dart';
import 'package:xingpin_mall_app/model/home_model.dart';
import 'package:xingpin_mall_app/model/mall_model.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/pages/compenents/cached_image.dart';
import 'package:xingpin_mall_app/pages/compenents/search_bar.dart';
import 'package:xingpin_mall_app/pages/widget/loading_container.dart';
import 'package:xingpin_mall_app/router/routers.dart';
import 'package:xingpin_mall_app/store/app_store.dart';


import '../../model/mall_model.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _pageLoading = true; // 页面加载
  List<CoverModel> _bannerList = [];
  int _bannerIndex = 0;
  List<TabBarModel> _tabBarList = [];
  TabController _tabController;
  List<CoverModel> _channelList = [];
  List<ProductModel> _productList = [];


  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    // TODO: implement initState
    super.initState();
    initPageData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _pageLoading,
        child: Column(
          children: <Widget>[
            _searchBar,
            _tabBarNav,
            _tabBarView
          ],
        ),
      ),
    );
  }



  /// 初始化页面数据
  void initPageData() {
    /// 获取首页内容
    HomeApi.homeBuild((HomeModel model){
      setState(() {
        _bannerList = model.bannerList ?? [];
        _tabBarList = model.tabBarList ?? [];
        _channelList = model.channelList ?? [];
        _productList = model.productList ?? [];
        _tabController = TabController(length: _tabBarList?.length, vsync: this);
        _pageLoading = false;
      });
    });
  }

  /// 搜索
  Widget get _searchBar{
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: SearchBar(
        searchBarType: SearchBarType.homeLight,
        inputBoxClick: _jumpToSearch,
        speakClick: _jumpToSpeak,
        defaultText: 'samsung',
        leftButtonClick: () {},
      ),
    );
  }


  /// tabbar
  Widget get _tabBarNav {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(0),
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.black,
//          labelPadding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          indicator: UnderlineIndicator(
              strokeCap: StrokeCap.round,
              borderSide: BorderSide(
                color: Provider.of<AppStore>(context,listen: false).primaryColor,
                width: 3,
              ),
              insets: EdgeInsets.only(bottom: 8)),
          tabs: _tabBarList.map<Tab>((TabBarModel tab) {
            return Tab(
              text: tab.name,
            );
          }).toList()),
    );
  }

  /// tabbar 视图部分
  Widget get _tabBarView {
    return Flexible(
        child: TabBarView(
          controller: _tabController,
          children: _tabBarList.map((TabBarModel tab){
            if(tab.code == 'home'){
              return _homeTabBarView(tab);
            }else{
              return _categoryTabBarView(tab);
            }
          }).toList(),
        )
    );

  }

  /// 首页tabbar视图
  Widget  _homeTabBarView(TabBarModel tab){
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          _bannerWidget(),
          _channelWidget(),
          _productWidget()
        ],
      ),
    );

  }

  /// 分类tabbar视图
  Widget  _categoryTabBarView(TabBarModel tab){
    return Text(tab.name);
  }

  /// banner
  Widget  _bannerWidget() {
    return Container(
      padding: EdgeInsets.all(0),
      height: 160,
      child: Swiper(
        index: _bannerIndex,
        itemCount: _bannerList.length,
        autoplay: false,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CoverModel banner = _bannerList[index];
              print(banner.link);
            },
            child: CachedImageBox(url: _bannerList[index].img),
          );
        },
        pagination: SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                size: 8.0,
                color: Colors.white,
                activeColor: Provider.of<AppStore>(context,listen: false).primaryColor)
        ),
      ),
    );
  }

  /// 商城 导航频道入口
  Widget _channelWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.all(7),
          child: _channelItems(context),
        ),
      ),
    );
  }

  /// 导航频道 items
  _channelItems(BuildContext context) {
    List<Widget> items = [];
    _channelList.forEach((model) {
      items.add(_channelItem(context, model));
    });
    //计算出第一行显示的数量
    int separate = (_channelList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, _channelList.length),
          ),
        )
      ],
    );
  }

  /// 导航频道 item
  Widget _channelItem(BuildContext context, CoverModel model) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          print('跳转');
        },
        child: Column(
          children: <Widget>[
            CachedImageBox(url: model.img,width: ScreenUtil().setSp(64),height: ScreenUtil().setSp(64)),
            Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              model.name,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  /// 精选商品推荐
  Widget _productWidget() {
     return GridView.builder(
      shrinkWrap: true,
      itemCount: _productList.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return _productItem(item: _productList[index]);
      },
    );
  }

  Widget _productItem({ProductModel item}) {
    return Container(
      child: InkWell(
        onTap: (){
          print('商品详情');
        },
        child: Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        CachedImageBox(url: item.img)
                      ],
                    ),
                  ),
                ),
//              Padding(padding: EdgeInsets.only(top: 5)),
                SizedBox(
                  child: Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                Container(
//                  padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '¥ ${item.salePrice}',
                          style: TextStyle(
                              color: Color(0xfff23030)
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _handleRefresh() async{
    await Future.delayed(Duration(seconds: 2));
    print('首页下拉刷新');
  }

  _jumpToSearch() {
    Navigator.pushNamed(context, RouterNames.search,arguments: {"name":"search"});
    print('跳转至搜索页');
  }

  _jumpToSpeak() {
    print('语音搜索');
  }

}
