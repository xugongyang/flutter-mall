

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/api/cart_api.dart';

import 'package:xingpin_mall_app/api/global_config.dart';
import 'package:xingpin_mall_app/model/cart_model.dart';

import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/pages/compenents/cached_image.dart';
import 'package:xingpin_mall_app/pages/compenents/input_number.dart';
import 'package:xingpin_mall_app/pages/widget/loading_container.dart';
import 'package:xingpin_mall_app/store/app_store.dart';
import 'package:xingpin_mall_app/store/cart_store.dart';
import 'package:xingpin_mall_app/utils/translations.dart';



class CartPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List <ProductModel> _productList = [];
  bool _pageLoading = true;
  CartStore _cartStore = new CartStore(); // 用户状态管理


  @override
  void initState() {
    super.initState();

    initPageData();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Translations.of(context).text('shopping_cart')),
        centerTitle: true,
      ),
      body: LoadingContainer(
        isLoading: _pageLoading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
              children: <Widget>[
                _cartWidget(),
                Container(
                  height: 50,
                  child: Center(
                    child: Text('猜你喜欢'),
                  ),
                ),
                _productWidget()
              ]
          ),
        ),
      ),
      bottomNavigationBar: Container(child: _cartCalc()),
    );
  }

  /// 页面初始化
  void initPageData() {
    /// 购物车列表
    CartApi.cartList((CartModel model){
      if(model.cartList.length > 0){
        setState(() {
          model.cartList.forEach((item) {
            item.checked = true; // 默认选中
          });
          Provider.of<CartStore>(context,listen: false).setCartList(model.cartList);
          _cartStore = Provider.of<CartStore>(context,listen: false);
          _pageLoading = false;
        });
      }

    });

    /// 推荐商品 猜你喜欢
    GlobalConfigApi.recommendProduct((RecommendProductModel model){
      setState(() {
        _productList = model.guessLike;

      });
    });

  }

  /// 购物车列表
  Widget  _cartWidget() {
    if(_cartStore.cartList.length < 1){
      return Container();
    }
    return Column(
      children: _cartStore.cartList.map((ProductModel item){return _renderCartItem(item);}).toList(),
    );
  }

  Widget _renderCartItem(ProductModel item) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                item.checked = !item.checked;
                _cartStore.updateCartItem(item);

              },
              child: item.checked ? Icon(Icons.check_circle,color: Color(0xff1429a0)) : Icon(Icons.radio_button_unchecked),
            ),
            Container(
                width: 120,
                padding: EdgeInsets.only(right: 10,left: 10),
                child: Stack(
//                  fit: StackFit.passthrough,
                  children: <Widget>[
                    CachedImageBox(url: item.img,width: 100,height: 100,)

                  ],
                )
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(item.title),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(item.sku,style: TextStyle(color: Color(0xff999999)),),
                      ),
                      InputNumber(product: item),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 8)),
                  Text('¥ ${item.salePrice}',style: TextStyle(color: Color(0xff1358b2)),),
                  Padding(padding: EdgeInsets.only(top: 5))
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  /// 购物车计算
 Widget _cartCalc() {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: ShapeDecoration(
          color: Color(0xfff8f6f7),
          shape: Border(
              top: BorderSide(
                  color: Color(0xffededed), width: 1.0))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              setState(() {
                _cartStore.checkedAll(!_cartStore.isAllCheck);
              });
            },
            child: Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  _cartStore.isAllCheck
                      ?Icon(
                    Icons.check_circle,
                    color: Provider.of<AppStore>(context).primaryColor,
                  )
                      :Icon(Icons.radio_button_unchecked),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text('全选')
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('总计：'),
                  Text('¥ ${Provider.of<CartStore>(context).totalAmount}', style: TextStyle(color: Color(0xff1358b2),fontWeight: FontWeight.w500)),
                ],
              ),
            )
          ),
          Container(
            alignment: Alignment.centerRight,
            child: RaisedButton(
              onPressed: () {
                print('结算');
              },
              color: Provider.of<AppStore>(context).primaryColor,
              child: Row(
                children: <Widget>[
                  Text('去结算', style: TextStyle(color: Colors.white, fontSize: 16)),
                  Text('(${Provider.of<CartStore>(context).totalCount}件)', style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
          )

        ],
      ),
    );
 }




  /// 猜你喜欢产品列表
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
    await Future.delayed(Duration(seconds: 1));
    print('下拉刷新');
  }
}




/// 猜你喜欢 瀑布流结构
