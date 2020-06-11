

import 'package:json_annotation/json_annotation.dart';
part 'logistics_model.g.dart';

@JsonSerializable()
class LogisticsModel {
  String code;  // 物流单号
  String name;  // 承运人
  String phone; // 承运人电话
  List<LogisticsStepModel> logisticsStepList;

  LogisticsModel({this.code,this.name,this.phone,this.logisticsStepList});
  factory LogisticsModel.fromJson(Map<String, dynamic> strJson) => _$LogisticsModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$LogisticsModelToJson(this);

}

@JsonSerializable()
class LogisticsStepModel{
  String text; // 物流最新信息
  int time; // 时间戳
  String state; // 物流状态

  LogisticsStepModel({this.text,this.time,this.state});
  factory LogisticsStepModel.fromJson(Map<String, dynamic> strJson) => _$LogisticsStepModelFromJson(strJson);
  Map<String, dynamic> toJson() => _$LogisticsStepModelToJson(this);

}