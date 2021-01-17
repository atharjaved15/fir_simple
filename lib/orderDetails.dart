import 'package:fir_simple/location.dart';
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

class orderDetails extends StatelessWidget {
  String longitude,latitude;
  String uid, pid, name, l_details, o_price, n_price, img_path;

  orderDetails({
    @required this.latitude,
    @required this.longitude,
    @required this.uid,
    @required this.pid,
    @required this.name,
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

                RawMaterialButton(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context) => orders()));}

                ),
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
                'Order Details', style: TextStyle(color: Colors.white),)),
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
                                Text('Name: '+ name, textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25, color: Colors.white,),),
                                Text('Product ID: '+ pid, textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18, color: Colors.white,),),
                                Text('Price to Recieve: ' + n_price + '\$', textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20, color: Colors.greenAccent),),
                                Text('User Unique ID:   '+ uid, textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15, color: Colors.white,),),

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
                    color: Colors.blueAccent,
                    onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context) => location(longitude: longitude, latitude: latitude))),
                    child: Text('See Location',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    textColor: Colors.white,
                  ),
                ],
              ),
            )
        )
    );
  }
}