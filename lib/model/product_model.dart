
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

/// 产品类
@JsonSerializable()
class ProductModel {
  String title;
  String sku;
  String img;
  String link;
  double salePrice;
  int quantity;

  ///自定义业务属性 可空字段
  bool checked; // 是否选中

  ProductModel(this.title, this.sku,this.img, this.link, this.salePrice, this.quantity, {this.checked: false});

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}


@JsonSerializable()
class RecommendProductModel {
  List<ProductModel> guessLike;

  RecommendProductModel(this.guessLike);

  factory RecommendProductModel.fromJson(Map<String, dynamic> json) => _$RecommendProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendProductModelToJson(this);

}