// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mall_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoverModel _$CoverModelFromJson(Map<String, dynamic> json) {
  return CoverModel(
    json['img'] as String,
    name: json['name'] as String,
    link: json['link'] as String,
    channelCode: json['channelCode'] as String,
  );
}

Map<String, dynamic> _$CoverModelToJson(CoverModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'img': instance.img,
      'link': instance.link,
      'channelCode': instance.channelCode,
    };

TabBarModel _$TabBarModelFromJson(Map<String, dynamic> json) {
  return TabBarModel(
    json['name'] as String,
    json['code'] as String,
  );
}

Map<String, dynamic> _$TabBarModelToJson(TabBarModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
    };
