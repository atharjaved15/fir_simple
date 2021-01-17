import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
class location extends StatefulWidget {
  String latitude,longitude;
  location({
    @required this.latitude,
    @required this.longitude,
});
  @override
  _locationState createState() => _locationState();
}
class _locationState extends State<location> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _circles = HashSet<Circle>();
  final List<Marker> marker=[];
  @override
  void initState() {
    super.initState();
    _setCircles();
    _getLocationPermission();
  }
  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }
  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(double.parse(widget.latitude),double.parse(widget.longitude)),
          radius: 500,
          strokeWidth: 2,
          fillColor: Colors.white70),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Map')),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: (controller){
                setState(() {
                  controller=controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.latitude),double.parse(widget.longitude)),
                zoom: 12,
              ),
              markers: _markers,
              mapType: MapType.normal,
              circles: _circles,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}