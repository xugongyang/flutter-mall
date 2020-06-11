

import 'package:xingpin_mall_app/model/cart_model.dart';
import 'package:xingpin_mall_app/utils/api_request.dart';

class CartApi {

  static Future cartList(callback) async {
    var res = await ApiRequest.instance.get('/api/xinpin/cartList');
    CartModel model = CartModel.fromJson(res?.data);
    callback(model);
  }

}