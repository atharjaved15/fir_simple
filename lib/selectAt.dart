import 'package:fir_simple/AR.dart';
import 'package:flutter/material.dart';
class selectAr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              color: Colors.red,
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AR(image_3d_path: 'attach-demo-table.obj'))),
              },
              child: Text("Table", style: TextStyle(color: Colors.white),),
            ),
            MaterialButton(
              color: Colors.deepPurpleAccent,
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AR(image_3d_path: 'attach-demo-chair.obj'))),
              },
              child: Text("Chair", style: TextStyle(color: Colors.white),),
            ),
            MaterialButton(
              color: Colors.green,
              onPressed: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AR(image_3d_path: 'couchsofa.obj'))),
              },
              child: Text("Sofa", style: TextStyle(color: Colors.white),),
            ),
            
          ],
        ),
      ),
    );
  }
}
