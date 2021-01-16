import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class maps extends StatefulWidget {
  String latitude,Logitude;
  maps({
   @required this.latitude,
    @required this.Logitude,
});


  @override
  _mapsState createState() => _mapsState();
}

class _mapsState extends State<maps> {
  String get longitude => this.latitude;

  String get latitude => this.longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(latitude), double.parse(longitude)),
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController mapcontroller ){
                setState(() {
                  Marker(
                    markerId: MarkerId('1'),
                    position: LatLng(double.parse(latitude), double.parse(longitude)),
                  );
                });
              },

            ),
          ),
        ],
      ),
    );
  }
}
