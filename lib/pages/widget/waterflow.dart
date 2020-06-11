


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:xingpin_mall_app/api/global_config.dart';
import 'package:xingpin_mall_app/model/product_model.dart';

import 'loading_container.dart';

class WaterFlowPage extends StatefulWidget{
  @override
  _WaterFlowPageState createState() => _WaterFlowPageState();

}

class _WaterFlowPageState extends State<WaterFlowPage> with AutomaticKeepAliveClientMixin {
  List <ProductModel> _productList = [];
  ScrollController _scrollController = ScrollController();


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initPageData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('加载更多数据');
      }
    });

    super.initState();
  }


  void initPageData() {
    /// 推荐商品 猜你喜欢
    GlobalConfigApi.recommendProduct((RecommendProductModel model){
      setState(() {
        _productList = model.guessLike;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
     super.build(context);
     return Scaffold(
       body: LoadingContainer(
         isLoading: false,
         child: RefreshIndicator(
           onRefresh: _handleRefresh,
           child: MediaQuery.removePadding(
             removeTop: true,
             context: context,
             child: StaggeredGridView.countBuilder(
               controller: _scrollController,
               crossAxisCount: 4, //每一行显示几列
               itemCount: _productList?.length ?? 0,
               itemBuilder: (BuildContext context, int index) => _GuessLikeItem(
                 index: index,
                 item: _productList[index],
               ),
               staggeredTileBuilder: (int index) => new StaggeredTile.fit(2), // item 每行占2列空间
             ),
           ),
         ),

       ),
     );
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Future<Null> _handleRefresh() async {
    print('shuaxin');
    return null;
  }

}



class _GuessLikeItem extends StatelessWidget{
  final int index;
  final ProductModel item;

  _GuessLikeItem({Key key,this.item,this.index}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('商品详情');
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.img),
      ],
    );
  }
}