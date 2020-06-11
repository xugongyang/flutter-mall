
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/utils/api_request.dart';

/// 全局公共接口
class GlobalConfigApi {

  static Future recommendProduct(callback) async {
    var res = await ApiRequest.instance.get('/api/xinpin/recommendProduct');
    RecommendProductModel model = RecommendProductModel.fromJson(res.data);
    callback(model);
  }

}