/**
 * 公共组件 TabBar
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget{
  final String title;
  final List<TabBarWidgetModel> tabs;
  final bool tabScrollable;
  final TabController tabController;

  TabBarWidget({
    this.title,
    this.tabs,
    this.tabScrollable = true,
    this.tabController
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        bottom: TabBar(
          controller: this.tabController,
          isScrollable: this.tabScrollable,
          tabs: this.tabs.map((item) => Tab(text: item.title)).toList(),
        ),
      ),
      body: TabBarView(
        controller: this.tabController,
        children: this.tabs.map((item) => item.widget).toList(),
      ),
    );
  }

}


class TabBarWidgetModel {
  final String title;
  final Widget widget;

  const TabBarWidgetModel({
    this.title,
    this.widget,
  });
}