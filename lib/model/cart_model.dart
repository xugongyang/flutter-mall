

import 'package:json_annotation/json_annotation.dart';
import 'package:xingpin_mall_app/model/product_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  List <ProductModel> cartList;

  CartModel(this.cartList);

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);

}