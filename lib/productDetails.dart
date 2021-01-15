import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fir_simple/userPanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class productDetails extends StatelessWidget {

  String pid, name, l_details, o_price, n_price, img_path;

  productDetails({
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
                  InkWell(
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
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
                'Product Details', style: TextStyle(color: Colors.white),)),
            ),
            backgroundColor: Colors.black87,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                SizedBox(height: 50,),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(name, textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40, color: Colors.white,),),
                            Text(l_details , textAlign:TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white),),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(o_price + '\$' , textAlign:TextAlign.center,  style: TextStyle(fontSize: 20, color: Colors.white, decoration:TextDecoration.lineThrough,fontStyle: FontStyle.italic),),
                            Text(n_price + '\$', textAlign:TextAlign.left , style: TextStyle(fontWeight:FontWeight.bold,fontSize: 40, color: Colors.greenAccent),),
                            Text(FirebaseAuth.instance.currentUser.email.toString(), style: TextStyle(color: Colors.white),),
                          ],
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

              ],
            )
        )
    );
  }

  shopNow(BuildContext context) async {
    final f_ref = FirebaseFirestore.instance;
    String id = FirebaseAuth.instance.currentUser.uid.toString();
    f_ref.collection('cart').doc(id).collection('products').doc().set(
        {
          "product id": pid,
          "name": name,
          "price" : n_price,
          "image_path" : img_path,
          "dateTime": DateTime.now().toString(),
        }
    );
  }
}