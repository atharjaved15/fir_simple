import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class productDetails extends StatefulWidget {

  String name,l_details,o_price,n_price,img_path;
  productDetails({
    @required name,
    @required l_details,
    @required o_price,
    @required n_price,
    @required img_path,
});
  @override
  _productDetailsState createState() => _productDetailsState();

}
@override
State<StatefulWidget> createState( ) {
  // TODO: implement createState
  throw UnimplementedError();
}


class _productDetailsState extends State<productDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 10,
              toolbarHeight: 50.0,
              leadingWidth: 100,
              leading: Image(image: AssetImage('images/logo.png'),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
              ),
              title: Center(child: Text('Product Details', style: TextStyle(color: Colors.white),)),
            ),
            backgroundColor: Colors.black87,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('wwww')

              ],
            )
        )
    );
  }
}

