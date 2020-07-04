import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GMAP extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<GMAP> {
   
 
  Set<Marker> _markers = {};
    
    
  Completer<GoogleMapController> _controller = Completer();

BitmapDescriptor pinLocationIcon;
   @override
   void initState() {
      super.initState();
      setCustomMapPin();
   }
   void setCustomMapPin() async {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/img.png');
   }
  @override
   Widget build(BuildContext context) {
     LatLng pinPosition = LatLng(16.5062, 80.6480);
     CameraPosition initialLocation = CameraPosition(
      zoom: 16,
      bearing: 30,
      target: pinPosition
   );
    return MaterialApp(
      home: Scaffold(
       
        body: Stack(
  children: <Widget>[
    GoogleMap(
   myLocationEnabled: true,
   markers: _markers,
   initialCameraPosition: initialLocation,
   onMapCreated: (GoogleMapController controller) {
      _controller.complete(controller);
      setState(() {
         _markers.add(
            Marker(
               markerId: MarkerId('Sahihti'),
               position: pinPosition,
               icon: pinLocationIcon
            )
         );
      });
   }),
  ]  
      
    ),
    ),
    

    );
  }
}