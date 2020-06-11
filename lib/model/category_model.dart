
import 'package:json_annotation/json_annotation.dart';
import 'package:xingpin_mall_app/model/mall_model.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
part 'category_model.g.dart';

/// 产品分类
@JsonSerializable()
class CategoryModel {
  String name;
  String categoryId;

  CategoryModel(this.name, this.categoryId);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

}

/// 一级分类
@JsonSerializable()
class CategoryTabModel {
  List<CategoryModel> categoryTabs;

  CategoryTabModel(this.categoryTabs);

  factory CategoryTabModel.fromJson(Map<String, dynamic> json) => _$CategoryTabModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryTabModelToJson(this);
}

/// 一级子分类 下内容
@JsonSerializable()
class CategoryChildModel {
  // 二级分类
  CategoryModel category;
  // 二级分类产品列表
  List<ProductModel> productList;

  CategoryChildModel(this.category, this.productList);

  factory CategoryChildModel.fromJson(Map<String, dynamic> json) => _$CategoryChildModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryChildModelToJson(this);

}

/// 一级分类内容实体
@JsonSerializable()
class CategoryContentModel {

  List<CoverModel> bannerList;
  List<CategoryChildModel> childList;

  CategoryContentModel(this.childList, {this.bannerList});

  factory CategoryContentModel.fromJson(Map<String, dynamic> json) => _$CategoryContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryContentModelToJson(this);
}



