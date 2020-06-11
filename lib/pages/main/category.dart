
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/model/category_model.dart';
import 'package:xingpin_mall_app/model/mall_model.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/api/category_api.dart';
import 'package:xingpin_mall_app/pages/compenents/cached_image.dart';
import 'package:xingpin_mall_app/pages/widget/loading_container.dart';
import 'package:xingpin_mall_app/store/app_store.dart';

class CategoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
   String _activeCategoryId = '1';
   bool _pageLoading = true; // 是否页面加载
   List<CategoryModel> _categoryList = []; // 分类 tabs
   List<CoverModel> _bannerList = []; // 分类内容 tabs
   List<CategoryChildModel> _childList = []; // 分类内容


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _pageLoading,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Color(0xfff5f5f5),
                margin: EdgeInsets.only(right: 10),
                child: ListView(
                  children: _categoryList.map((CategoryModel item) {return _categoryTabItem(item);}).toList(),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: ListView(
                  children: <Widget>[
                    _cateChildBanner(),
                    _cateChildList(),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  void initState() {
    initPageData();
    super.initState();
  }

  void initPageData() {

    /// 分类tabs
    CategoryApi.categoryTabs((CategoryTabModel model){
      setState(() {
        _categoryList = model.categoryTabs;
      });
    });

    /// 分类内容
    CategoryApi.categoryContent((CategoryContentModel model){
      setState(() {
        if(model.bannerList != null){
          _bannerList = model.bannerList;
          _childList = model.childList;
          _pageLoading = false;
        }
      });
    });

  }



  /// 分类tab
  Widget _categoryTabItem(CategoryModel item) {

    if(_activeCategoryId == item.categoryId){
      return GestureDetector(
        onTap: (){
          setState(() {
            _activeCategoryId = item.categoryId;
          });
        },
        child: Container(
          height: 50,
          color: Color(0xffffffff),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                top: 17,
                child: Container(width: 5, height: 16,color: Color(0xff1429a0)),
              ),
              Center(
                child: Text(
                  item.name,
                  style: TextStyle(color: Provider.of<AppStore>(context,listen: false).primaryColor,fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: (){
        setState(() {
          _activeCategoryId = item.categoryId;
        });
      },
      child: Container(
        height: 46,
        child: Center(
          child: Text(
            item.name,
            style: TextStyle(color: Color(0xff333333)),
          ),
        ),
      ),
    );

  }


  /// 分类 banner
  Widget _cateChildBanner() {

    if(_bannerList.length ==0){
      return Container();
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 140,
      child: Swiper(
        index: 0,
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
                activeColor: Color(0xff1429a0))
        ),
      ),
    );
  }

  /// 分类 子集内容
  _cateChildList() {
    if(_childList.length < 1){
      return Container();
    }
    return Column(
        children: _childList.map((CategoryChildModel item){return _renderChildItem(item);}).toList()
    );
  }

  /// 渲染子集内容
   Widget _renderChildItem(CategoryChildModel item) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      margin: EdgeInsets.only(bottom: 10),
      color: Color(0xffffffff),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(item.category?.name),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: item.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index){
              return _cateItemProduct(item.productList[index]);
            },
          )
        ],
      ),
    );
  }

  Widget _cateItemProduct(ProductModel product) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              CachedImageBox(url: product.img)
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Text(product.title)
      ],
    );
  }


}