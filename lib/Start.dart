import 'package:flutter/material.dart';
import 'loginScreen.dart';
class Start extends StatelessWidget {

  Color primaryColor = Colors.black87;
  Color secondaryColor = Colors.white;
  Color logoColor  =   Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //We take the image from the assets
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'images/logo.png',
                        height: 250,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Texts and Styling of them
                    Text(
                      'Welcome to IDA !',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 28),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'A one-stop portal for you to Shop Online and Experience Augmented Reality',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    //Our MaterialButton which when pressed will take us to a new screen named as
                    //LoginScreen
                    MaterialButton(
                      elevation: 0,
                      height: 50,
                      color: Colors.black87,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => loginScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Get Started',
                              style: TextStyle(color: Colors.white, fontSize: 20)),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                      textColor: Colors.white,
                    )
                  ],
                ),
        ),
            ),
    );
  }
}
