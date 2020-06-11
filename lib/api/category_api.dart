
import 'package:dio/dio.dart';
import 'package:xingpin_mall_app/model/category_model.dart';
import 'package:xingpin_mall_app/utils/api_request.dart';

class CategoryApi {

  /// 分类tab
  static Future categoryTabs(callback) async {
    Response response = await ApiRequest.instance.get('/api/xinpin/categoryTabs');
    CategoryTabModel model = CategoryTabModel.fromJson(response.data);
    callback(model);
  }

  /// 分类内容
  static Future categoryContent(callback) async {
    Response response = await ApiRequest.instance.get('/api/xinpin/categoryContent');
    CategoryContentModel model = CategoryContentModel.fromJson(response.data);
    callback(model);
  }

}