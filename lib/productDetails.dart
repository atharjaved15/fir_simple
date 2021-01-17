import 'package:fir_simple/AR.dart';
import 'package:fir_simple/cart.dart';
import 'package:fir_simple/selectAt.dart';
import 'package:fir_simple/userPanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'orders.dart';

class productDetails extends StatelessWidget {
  String longitude,latitude;
  String pid, name, l_details, o_price, n_price, img_path,img_3d_path;

  productDetails({
    @required this.img_3d_path,
    @required this.pid,
    @required this.name,
    @required this.l_details,
    @required this.o_price,
    @required this.n_price,
    @required this.img_path,
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              actions: [
                 Row(
                   children: [
                     InkWell(
                       onTap:() => {
                         Navigator.push(context, MaterialPageRoute(builder: (context) => cart())),
                       },
                       child: Icon(
                         Icons.add_shopping_cart,
                         color: Colors.white,
                       ),
                     ),
                     SizedBox(width: 20,),
                     InkWell(
                       onTap: ()=>{
                         Navigator.push(context, MaterialPageRoute(builder: (context) => selectAr())),
                       },
                       child:
                       Icon(
                         Icons.camera_rear_outlined,
                       ),
                     ),
                     RawMaterialButton(
                         child: Icon(
                           Icons.arrow_back,
                           color: Colors.white,
                         ),
                         onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => userPanel()));}

                     ),
                   ],
                 )
              ],
              backgroundColor: Colors.transparent,
              elevation: 10,
              toolbarHeight: 50.0,
              leadingWidth: 100,
              leading: Image(image: AssetImage('images/logo.png'),
                color: Colors.white,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
              ),
              title: Center(child: Text(
                'Details', style: TextStyle(color: Colors.white),)),
            ),
            backgroundColor: Colors.black87,
            body: Container(
              height: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .45,
                    width: double.maxFinite,
                    child: Image.network(img_path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(name, textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40, color: Colors.white,),),
                                Text(l_details , textAlign:TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white),),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(o_price + '\$' , textAlign:TextAlign.center,  style: TextStyle(fontSize: 20, color: Colors.white, decoration:TextDecoration.lineThrough,fontStyle: FontStyle.italic),),
                                Text(n_price + '\$', textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40, color: Colors.greenAccent),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () => shopNow(context),
                    color: Colors.green,
                    child: Text('Shop Now',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.maxFinite,
                    height: 50,
                    onPressed: () => addtoCart(context),
                    color: Colors.blueAccent,
                    child: Text('Add to Cart',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),

                ],
              ),
            )
        )
    );
  }
  addtoCart(BuildContext context) async {
    showAlertDialog1(context);
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    longitude= geoposition.longitude.toString();
    latitude = geoposition.latitude.toString();
    final f_ref = FirebaseFirestore.instance;
    String id = FirebaseAuth.instance.currentUser.uid.toString();
    f_ref.collection('cart').doc(id).collection('products').doc().set(
        {
          "product id": pid,
          "name": name,
          "price" : n_price,
          "image_path" : img_path,
          "dateTime": DateTime.now().toString(),
          "longitude" : longitude,
          "latitude" : latitude,
        }
    );

  }

  shopNow(BuildContext context) async {
    showAlertDialog(context);
    final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    longitude= geoposition.longitude.toString();
    latitude = geoposition.latitude.toString();
    final f_ref = FirebaseFirestore.instance;
    String id = FirebaseAuth.instance.currentUser.uid.toString();
    f_ref.collection('orders').doc('order').collection('products').doc().set(
        {
          "user ID" : id,
          "product id": pid,
          "name": name,
          "price" : n_price,
          "image_path" : img_path,
          "dateTime": DateTime.now().toString(),
          "longitude" : longitude,
          "latitude" : latitude,
        }
    );

  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Order Placed"),
      content: Text("Thank You for Placing the Order.."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


}
  showAlertDialog1(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Items Added to the Cart"),
      content: Text("Thank You ! Your Items have been added to the cart!"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );


  }
}
