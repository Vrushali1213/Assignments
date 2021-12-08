import 'dart:async';

import 'package:appnew/markersPoint.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => new _MapPageState();
}


class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  Iterable markers = [];

  Iterable _markers = Iterable.generate(MarkerPoints.list.length, (index) {
    return Marker(
        markerId: MarkerId(MarkerPoints.list[index]['id']),
        position: LatLng(
          MarkerPoints.list[index]['lat'],
          MarkerPoints.list[index]['lon'],
        ),
        infoWindow: InfoWindow(title: MarkerPoints.list[index]["title"])
    );
  });



  @override
  void initState() {
    setState(() {
      markers = _markers;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          mapType: MapType.normal,
//          initialCameraPosition: CameraPosition(target: LatLng(23.7985053,
//              90.3842538), zoom: 13),
          initialCameraPosition: CameraPosition(target: LatLng(12.9610,77.6387), zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(markers),
        ),
      ),
    );
  }

}