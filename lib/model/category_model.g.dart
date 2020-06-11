// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    json['name'] as String,
    json['categoryId'] as String,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
    };

CategoryTabModel _$CategoryTabModelFromJson(Map<String, dynamic> json) {
  return CategoryTabModel(
    (json['categoryTabs'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryTabModelToJson(CategoryTabModel instance) =>
    <String, dynamic>{
      'categoryTabs': instance.categoryTabs,
    };

CategoryChildModel _$CategoryChildModelFromJson(Map<String, dynamic> json) {
  return CategoryChildModel(
    json['category'] == null
        ? null
        : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    (json['productList'] as List)
        ?.map((e) =>
            e == null ? null : ProductModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryChildModelToJson(CategoryChildModel instance) =>
    <String, dynamic>{
      'category': instance.category,
      'productList': instance.productList,
    };

CategoryContentModel _$CategoryContentModelFromJson(Map<String, dynamic> json) {
  return CategoryContentModel(
    (json['childList'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryChildModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bannerList: (json['bannerList'] as List)
        ?.map((e) =>
            e == null ? null : CoverModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryContentModelToJson(
        CategoryContentModel instance) =>
    <String, dynamic>{
      'bannerList': instance.bannerList,
      'childList': instance.childList,
    };
