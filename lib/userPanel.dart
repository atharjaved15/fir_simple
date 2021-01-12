import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
              )
          )
    );
  }
}
