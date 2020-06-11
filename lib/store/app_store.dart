

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppStore with ChangeNotifier {

  // 主题颜色
  Color _primaryColor = Color(0xff1429a0);

  // 主题设置
  ThemeData _themeData = ThemeData(
      primaryColor: Colors.white
  );

  Color get primaryColor => _primaryColor;
  ThemeData get themeData => _themeData;

  /// 设置主题颜色
  setPrimaryColor(Color color) async {
    _primaryColor = color;
    notifyListeners();
  }

  /// 设置主题数据
  setThemeData(ThemeData data) async {
    _themeData = data;
    notifyListeners();
  }


}