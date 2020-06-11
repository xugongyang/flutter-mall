

import 'package:json_annotation/json_annotation.dart';
import 'package:xingpin_mall_app/model/mall_model.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
part 'home_model.g.dart';

/// 首页模型
@JsonSerializable()
class HomeModel {
  List<CoverModel> bannerList; // banner
  List<CoverModel> channelList; // 功能频道入口
  List<TabBarModel> tabBarList; // 头部 tabbar
  List<ProductModel> productList; // 推荐产品列表

  HomeModel(this.bannerList,this.channelList,this.tabBarList,this.productList);

  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

}