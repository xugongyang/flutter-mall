

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// 用户实体
@JsonSerializable()
class UserModel{
  String name;
  String phone;
  String address;
  
  UserModel({this.name,this.phone,this.address});

  factory UserModel.fromJson(Map<String, dynamic> strJson) => _$UserModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}



