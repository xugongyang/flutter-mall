// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    json['title'] as String,
    json['sku'] as String,
    json['img'] as String,
    json['link'] as String,
    (json['salePrice'] as num)?.toDouble(),
    json['quantity'] as int,
    checked: json['checked'] as bool,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'sku': instance.sku,
      'img': instance.img,
      'link': instance.link,
      'salePrice': instance.salePrice,
      'quantity': instance.quantity,
      'checked': instance.checked,
    };

RecommendProductModel _$RecommendProductModelFromJson(
    Map<String, dynamic> json) {
  return RecommendProductModel(
    (json['guessLike'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RecommendProductModelToJson(
        RecommendProductModel instance) =>
    <String, dynamic>{
      'guessLike': instance.guessLike,
    };
