// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogisticsModel _$LogisticsModelFromJson(Map<String, dynamic> json) {
  return LogisticsModel(
    code: json['code'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    logisticsStepList: (json['logisticsStepList'] as List)
        ?.map((e) => e == null
            ? null
            : LogisticsStepModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LogisticsModelToJson(LogisticsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'phone': instance.phone,
      'logisticsStepList': instance.logisticsStepList,
    };

LogisticsStepModel _$LogisticsStepModelFromJson(Map<String, dynamic> json) {
  return LogisticsStepModel(
    text: json['text'] as String,
    time: json['time'] as int,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$LogisticsStepModelToJson(LogisticsStepModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'time': instance.time,
      'state': instance.state,
    };
