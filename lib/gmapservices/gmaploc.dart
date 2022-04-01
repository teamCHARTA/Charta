

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
class GmapLoc extends StatefulWidget {
  final LatLng latlng;
  GmapLoc({ Key? key,required this.latlng }) : super(key: key);

  @override
  _GmapLocState createState() => _GmapLocState();
}

class _GmapLocState extends State<GmapLoc> {

  List<Marker> allMarkers =[];

  late GoogleMapController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allMarkers.add(Marker(markerId: MarkerId('Client'),
    position: widget.latlng,
    ),);
  }
  
  final CameraPosition _initialCameraPosition=const CameraPosition(
    target: LatLng(8.5241,76.9366),
    zoom: 11.5
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            initialCameraPosition: _initialCameraPosition,
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
              onTap: (LatLng pos) {
            setState(() {
              //assign pos value to your LatLng
              print('${pos.latitude}, ${pos.longitude}');
            });}
            ),
            Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: movetoClient,
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.green
              ),
              child: Icon(Icons.location_on, color: Colors.white),
            ),
          ),
        ),
        ],
      ),
    );
  }
  void mapCreated(controller) {
  setState(()
  {
    _controller= controller;
  }
  );
 }

 movetoClient() {
   _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: widget.latlng, zoom: 14.0, bearing: 45.0, tilt: 45.0),
    ));
 }
}
