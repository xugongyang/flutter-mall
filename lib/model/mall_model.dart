
import 'package:json_annotation/json_annotation.dart';

/// 商城通用分类

part 'mall_model.g.dart';

/// 封面链接实体 banner、channel
@JsonSerializable()
class CoverModel {
  String name;
  String img;
  String link;
  String channelCode;

  CoverModel(this.img, {this.name, this.link, this.channelCode});

  factory CoverModel.fromJson(Map<String, dynamic> strJson) => _$CoverModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$CoverModelToJson(this);
}

/// tabBar
@JsonSerializable()
class TabBarModel {
  String name;
  String code;

  TabBarModel(this.name, this.code);

  factory TabBarModel.fromJson(Map<String, dynamic> strJson) => _$TabBarModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$TabBarModelToJson(this);
}

