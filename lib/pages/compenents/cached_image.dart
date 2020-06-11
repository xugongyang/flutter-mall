
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// 缓存网络图片
class CachedImageBox extends StatelessWidget{

  final String url;
  final double width;
  final double height;

  CachedImageBox({this.url,this.width = double.infinity,this.height = double.infinity});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: this.url,
      fit: BoxFit.contain,
      width: this.width,
      height: this.height,
      placeholder: (BuildContext context, String url) {
        return Container(
          width: this.width,
          color: Colors.grey[350],
          height: this.height,
          alignment: Alignment.center,
          child: Text(
            'Loading...',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(26.0),
                color: Colors.white),
          ),
        );
      },
    );
  }

}
