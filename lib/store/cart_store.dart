

import 'package:flutter/cupertino.dart';
import 'package:xingpin_mall_app/model/product_model.dart';

class CartStore with ChangeNotifier {
  List<ProductModel> _cartList = []; // 购物车列表
  int _totalCount = 0; // 购物车选中商品数量
  double _totalAmount = 0; // 购物车选中商品金额
  bool _isAllCheck = true; // 是否全选

  List<ProductModel> get cartList => _cartList;
  int get totalCount => _totalCount;
  double get totalAmount => _totalAmount;
  bool get isAllCheck => _isAllCheck;


  setCartList(List<ProductModel> list) async {
    _cartList = list;
    _cartCalc();
  }

  updateCartItem(ProductModel item) async {
    //TODO 根据购物车ID 查找需要修改购物车 列表项（index）
    int index = _cartList.indexWhere((w){return w.title == item.title;});
    if(index >= 0 && index < _cartList.length){
      _cartList[index] = item;
      _cartCalc();
    }
  }

  checkedAll(bool checked) async {
    _cartList.forEach((item){
      item.checked = checked;
    });
    _cartCalc();
  }


  /// 购物车计算
  void _cartCalc() {
    int count = 0;
    double amount = 0;
    _cartList.forEach((item) {
      if(item.checked){
        count += item.quantity;
        amount += item.salePrice * item.quantity;
      }
    });
    _totalCount = count;
    _totalAmount = amount;
    _isAllCheck = _cartList.every((item){return item.checked;});
    notifyListeners();
  }




}