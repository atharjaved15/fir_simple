/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class userPanel extends StatefulWidget {
  @override
  _userPanelState createState() => _userPanelState();
}

class _userPanelState extends State<userPanel> {
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
          Column(
            children: [
              Container(
                child: Column(
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              CustomScrollView(
                slivers: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("products").snapshots(),
                    builder: (context , dataSnapshot) {
                      return !dataSnapshot.hasData
                          ?SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),),)
                          :StaggeredGridView.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context , index ){
                          var data = dataSnapshot.data.documents[index].data;
                          return Info(data);
                        },
                        itemCount: dataSnapshot.data.documents.length,

                      );
                    },
                  )
                ],
              ),

            ],
          ),

        )
    );
  }

  Widget Info(data) {
    return InkWell(
      splashColor: Colors.pink,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 190.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(),
              SizedBox(width: 4.0,),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 15.0,),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text('Title'),

                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text('Description'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.pink,
                          ),
                          alignment: Alignment.topLeft,
                          width: 40.0,
                          height: 40.0,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('OFF'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flexible(child: Container()),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
