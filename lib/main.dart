import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:async';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:location/location.dart';

main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pintitionr',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: MapScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _markers = {};
  late GoogleMapController mapController;
  static const initialCam = CameraPosition(
    target: LatLng(28.6024, -81.2001),
    zoom: 15.5,
  );

  CameraPosition _position = initialCam;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(
        mapType: MapType.hybrid,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: initialCam,
        onMapCreated: _onMapCreated,
        markers: _markers,
        myLocationEnabled: true,
        compassEnabled: true,
        onCameraMove: _updateCameraPosition,
        onTap: _handleTap,
      ),
      // Positioned(
      //   bottom: 50,
      //   right: 10,
      //   // child: FlatButton(
      //   //     child: Icon(Icons.pin_drop, color: Colors.white),
      //   //     color: Colors.green,
      //   //     onPressed: _addMarker
      //   //     ),
      // )
    ]);
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      // _markers = {};
      _markers.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          },
          infoWindow: InfoWindow(
            title: '📋 Petitioner',
            snippet: 'University',
          )));
    });
  }

  void _updateCameraPosition(CameraPosition position) {
    setState(() {
      _position = position;
    });
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      // _markers.add(
      //   Marker(
      //       markerId: MarkerId('id-1'),
      //       position: LatLng(28.6024, -81.2001),
      //       infoWindow: InfoWindow(
      //         title: '📋 Petitioner',
      //         snippet: 'University',
      //       )),
      // );
    });
  }
}
