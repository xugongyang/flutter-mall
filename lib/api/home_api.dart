

import 'package:xingpin_mall_app/model/home_model.dart';
import 'package:xingpin_mall_app/utils/api_request.dart';

class HomeApi {

  /// 首页初始化
  /// callback 回调函数
  static Future homeBuild(callback) async {
    var res = await ApiRequest.instance.get('/api/xinpin/homeBuild');
    HomeModel model = HomeModel.fromJson(res?.data);
    callback(model);
  }

}