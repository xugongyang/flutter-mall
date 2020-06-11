import 'package:flutter/material.dart';

/// 加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  LoadingContainer({Key key, @required this.isLoading, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading ? _loadingView : child;
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

}
