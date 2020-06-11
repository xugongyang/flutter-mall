/*
 * http 请求封装
 * dio 拦截处理
 */

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xingpin_mall_app/utils/shared_preferences.dart';

var dio;

class ApiRequest {

  static ApiRequest _apiRequest;
  static ApiRequest get instance => _getInstance();

  /// 单例工厂
  static _getInstance() {
    if(_apiRequest == null){
      _apiRequest = ApiRequest();
    }
    return _apiRequest;
  }

  /// 拦截器处理
  ApiRequest(){
    BaseOptions options = BaseOptions(
      baseUrl: 'https://activity.utoper.net', // 请求基地址
//      baseUrl: 'http://2fdbab09.ngrok.io', // 请求基地址 本地测试
      connectTimeout: 10 * 1000, // 连接服务器超时时间
      receiveTimeout: 10 * 1000, // 接收数据的最长时限
    );

    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          // 在请求被发送之前做一些事情
          dio.lock();
          await SharedPreferencesUtil.getToken().then((token) {
            options.headers['access-token'] = token;
          });
          dio.unlock();
          return options; //continue
          // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
          // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
          //
          // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
          // 这样请求将被中止并触发异常，上层catchError会被调用。
        },
        onResponse:(Response response) async {
          // 在返回响应数据之前做一些预处理
          return response;
        },
        onError: (DioError err) async {
          // 当请求失败时做一些预处理
          print(err);
          Fluttertoast.showToast(msg: 'request error');
          return null;//continue
        }
    ));
  }


  Future get(String url,{Map<String, dynamic> queryParams}) async {
    if(queryParams != null){
      return await dio.get(url, queryParameters: queryParams);
    }
    return await dio.get(url);
  }

  Future post(String url,{Map<String, dynamic> postData}) async {
    if(postData != null) {
      return await dio.post(url, data: postData);
    }

    return await dio.post(url);
  }


}
