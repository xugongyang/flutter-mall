

import 'package:xingpin_mall_app/model/trade_model.dart';
import 'package:xingpin_mall_app/utils/api_request.dart';

class TradeApi {

  /// 交易单列表
  static Future tradeList(callback) async {
    var res = await ApiRequest.instance.get('/api/xinpin/tradeList');
    TradeListModel model = TradeListModel.fromJson(res?.data);
    callback(model);
  }

  /// 交易单详情
  static Future tradeDetail(callback) async {
    var res = await ApiRequest.instance.get('/api/xinpin/tradeDetail');
    TradeModel model = TradeModel.fromJson(res?.data);
    callback(model);
  }

}