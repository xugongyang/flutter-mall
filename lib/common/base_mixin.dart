
import 'package:date_format/date_format.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BaseMixin {

  static BaseMixin _baseMixin;
  static BaseMixin get instance => _getInstance();

  static _getInstance() {
    if(_baseMixin == null){
      _baseMixin = BaseMixin();
    }
    return _baseMixin;
  }

  /// 弹窗提示
   void toast (String msg){
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER
    );
  }

  /// 时间日期格式化
   String momentFormat(int timestamp,{String format = 'YYYY-MM-DD HH:mm:ss'}){
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    switch(format){
      case 'YYYY-MM-DD HH:mm:ss':
        return formatDate(dt, [yyyy,'-',mm,'-',dd,' ',hh,':',nn,':',ss]);
        break;
      case 'YYYY-MM-DD HH:mm':
        return formatDate(dt, [yyyy,'-',mm,'-',dd,' ',hh,':',nn]);
        break;
      default:
        return formatDate(dt, [yyyy,'-',mm,'-',dd,' ',hh,':',nn,':',ss]);
        break;
    }
  }



}