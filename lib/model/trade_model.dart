

import 'package:json_annotation/json_annotation.dart';
import 'package:xingpin_mall_app/model/logistics_model.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/model/user_model.dart';

part 'trade_model.g.dart';

/// 交易单模型
@JsonSerializable()
class TradeModel {
  String shopTitle;
  String tradeCode;
  String status;
  String state;
  // 实付款
  double payAmount;
  // 运费
  double freightAmount;
  // 折扣
  double discountAmount;
  // 收货人信息
  UserModel userInfo;
  LogisticsStepModel logisticsLatest;
  List<ProductModel> productList;

  TradeModel({
    this.shopTitle,
    this.tradeCode,
    this.status,
    this.state,
    this.payAmount,
    this.freightAmount,
    this.discountAmount,
    this.userInfo,
    this.logisticsLatest,
    this.productList});

  factory TradeModel.fromJson(Map<String, dynamic> strJson) => _$TradeModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$TradeModelToJson(this);

}

/// 交易单列表
@JsonSerializable()
class TradeListModel {
  List<TradeModel> tradeList;

  TradeListModel(this.tradeList);
  factory TradeListModel.fromJson(Map<String, dynamic> strJson) => _$TradeListModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$TradeListModelToJson(this);
}





