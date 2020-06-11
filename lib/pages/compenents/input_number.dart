


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xingpin_mall_app/common/base_mixin.dart';
import 'package:xingpin_mall_app/model/product_model.dart';
import 'package:xingpin_mall_app/store/cart_store.dart';

class InputNumber extends StatefulWidget{
  final ProductModel product;

  InputNumber({Key key, this.product}) : super(key: key);

  @override
  _InputNumberState createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber>{

  TextEditingController _controller = TextEditingController();
  CartStore _cartStore;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    if(widget.product.quantity != null){
      setState(() {
        _controller.text = widget.product.quantity.toString();
      });
    }

    super.initState();
 
  }

  @override
  Widget build(BuildContext context) {
    _cartStore = Provider.of(context,listen: false);

    return Container(
      width: 84,
      child: Row(
        children: <Widget>[
          InkWell(
              onTap: () => _reduce(),
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    shape: Border(
                        left: BorderSide(color: Color(0xffededed), width: 1.0),
                        top: BorderSide(color: Color(0xffededed), width: 1.0),
                        right: BorderSide(color: Color(0xffededed), width: 1.0),
                        bottom: BorderSide(color: Color(0xffededed), width: 1.0))),
                child: Text(
                  "—",
                  style: TextStyle(
                      color: Color(0xff888888)),
                ),
              )),
          Expanded(
            flex: 1,
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 15)
              ),
            )
          ),
          InkWell(
              onTap: () => _plus(),
              child: Container(
                width: 24,
                height: 24,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                    shape: Border(
                        left: BorderSide(color: Color(0xffededed), width: 1.0),
                        top: BorderSide(color: Color(0xffededed), width: 1.0),
                        right: BorderSide(color: Color(0xffededed), width: 1.0),
                        bottom: BorderSide(color: Color(0xffededed), width: 1.0))),
                child: Text(
                  "+",
                  style: TextStyle(
                      color: Color(0xff888888)),
                ),
              )),


        ],
      ),
    );
  }

  _reduce() {
    if(widget.product.quantity <= 1){
      BaseMixin.instance.toast('最少购买1件哦');
    }
    if(widget.product.quantity > 1){
      setState(() {
        widget.product.quantity --;
        _controller.text = widget.product.quantity.toString();
      });
      _cartStore.updateCartItem(widget.product);
    }
  }

  _plus() {
    setState(() {
      widget.product.quantity ++ ;
      _controller.text = widget.product.quantity.toString();
    });
    _cartStore.updateCartItem(widget.product);
  }


  _onChanged(String text) {
    setState(() {
      widget.product.quantity = int.parse(text);
      _controller.text = widget.product.quantity.toString();
    });
    _cartStore.updateCartItem(widget.product);
  }
  
}