// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeModel _$TradeModelFromJson(Map<String, dynamic> json) {
  return TradeModel(
    shopTitle: json['shopTitle'] as String,
    tradeCode: json['tradeCode'] as String,
    status: json['status'] as String,
    state: json['state'] as String,
    payAmount: (json['payAmount'] as num)?.toDouble(),
    freightAmount: (json['freightAmount'] as num)?.toDouble(),
    discountAmount: (json['discountAmount'] as num)?.toDouble(),
    userInfo: json['userInfo'] == null
        ? null
        : UserModel.fromJson(json['userInfo'] as Map<String, dynamic>),
    logisticsLatest: json['logisticsLatest'] == null
        ? null
        : LogisticsStepModel.fromJson(
            json['logisticsLatest'] as Map<String, dynamic>),
    productList: (json['productList'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TradeModelToJson(TradeModel instance) =>
    <String, dynamic>{
      'shopTitle': instance.shopTitle,
      'tradeCode': instance.tradeCode,
      'status': instance.status,
      'state': instance.state,
      'payAmount': instance.payAmount,
      'freightAmount': instance.freightAmount,
      'discountAmount': instance.discountAmount,
      'userInfo': instance.userInfo,
      'logisticsLatest': instance.logisticsLatest,
      'productList': instance.productList,
    };

TradeListModel _$TradeListModelFromJson(Map<String, dynamic> json) {
  return TradeListModel(
    (json['tradeList'] as List)
        ?.map((e) =>
            e == null ? null : TradeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TradeListModelToJson(TradeListModel instance) =>
    <String, dynamic>{
      'tradeList': instance.tradeList,
    };
