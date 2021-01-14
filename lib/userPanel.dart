import 'package:fir_simple/productDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class userPanel extends StatefulWidget {
  @override
  _userPanelState createState() => _userPanelState();

}
@override
State<StatefulWidget> createState( ) {
  // TODO: implement createState
  throw UnimplementedError();
}


class _userPanelState extends State<userPanel> {
  String name,id,n_price,o_price,img_path,l_details;
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
          title: Center(child: Text('User Panel', style: TextStyle(color: Colors.white),)),
        ),
        backgroundColor: Colors.black87,
        body:
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(height: 30,),
                        CarouselSlider(
                          options: CarouselOptions(
                             height: 180.0,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 16/9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                          ),
                          items: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: AssetImage('images/1.jpg'),
                                  fit: BoxFit.cover,

                                )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('images/2.jpg'),
                                    fit: BoxFit.cover,

                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('images/3.jpg'),
                                    fit: BoxFit.cover,

                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('images/4.png'),
                                    fit: BoxFit.cover,

                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('images/5.jpg'),
                                    fit: BoxFit.cover,

                                  )
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage('images/6.jpg'),
                                    fit: BoxFit.cover,

                                  )
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50,
                          child: Center(
                            child: Text('RECENT PRODUCTS', style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 15),),
                          ),
                        ),
                        Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final List<DocumentSnapshot> documents = snapshot.data.docs;
                            setState(() {

                            });
                            return ListView(
                                children: documents
                                    .map((doc) => InkWell(
                                  onTap: () => productDetails(name: doc['name'], ),
                                      child: Container(
                                  height: 100,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: Colors.white.withOpacity(0.15),
                                                  height: 90,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 100,
                                                          child: Image.network(doc['product ID']),
                                                        ),
                                                        SizedBox(width: 50,),
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(doc['name'] , style: TextStyle(fontSize: 25, color: Colors.white),),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(width: 100,),
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(doc['price'] + '\$'  , style: TextStyle(fontSize: 15, color: Colors.grey[100], decoration:TextDecoration.lineThrough, fontStyle: FontStyle.italic )),
                                                              SizedBox(height: 5,),
                                                              Text(doc['price'] + '\$'  , style: TextStyle(fontSize: 30, color: Colors.greenAccent, fontStyle: FontStyle.italic),),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )


                                              ],
                                            )),
                                    )).toList());
                          } else if (snapshot.hasError) {
                            return Text('It\'s Error!');
                          }
                        }),
                        ),

  ]
                )
      )
    )
    );
  }
}



