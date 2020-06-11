// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    (json['bannerList'] as List)
        ?.map((e) =>
            e == null ? null : CoverModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['channelList'] as List)
        ?.map((e) =>
            e == null ? null : CoverModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['tabBarList'] as List)
        ?.map((e) =>
            e == null ? null : TabBarModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['productList'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'bannerList': instance.bannerList,
      'channelList': instance.channelList,
      'tabBarList': instance.tabBarList,
      'productList': instance.productList,
    };
