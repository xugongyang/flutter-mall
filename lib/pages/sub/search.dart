
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget{
  final Map arguments; // 页面传参

  SearchPage({Key key,this.arguments}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50),),
            Text('arguments.name=${widget.arguments["name"]?? 'name is null'}'),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

  }
}