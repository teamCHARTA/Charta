import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class LocMapSel extends StatefulWidget {
  const LocMapSel({Key? key}) : super(key: key);

  @override
  _LocMapSelState createState() => _LocMapSelState();
}
late GoogleMapController _controller;
double lat=0.00000;
double lon=0.00000;
class Loc {
  double lat=0.00000;
  double lon=0.00000;

  Loc({required this.lat, required this.lon});
}
class _LocMapSelState extends State<LocMapSel> {
  @override
  Widget build(BuildContext context) {

    final CameraPosition _initialCameraPosition=const CameraPosition(
        target: LatLng(8.5241,76.9366),
        zoom: 11.5
    );
    return Scaffold(
      appBar: AppBar(title:Text("Tap on your location"),),
        body: Stack(

          children:[
            GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: mapCreated,
            initialCameraPosition: _initialCameraPosition, //and/or any other parameters
            onTap: (LatLng pos) {
              setState(() {
                lat=pos.latitude;
                lon=pos.longitude;
                print('${pos.latitude}, ${pos.longitude}');
                print('${lat}, ${lon}');
              });
            },),
          ElevatedButton(onPressed:(){

            if(lat==0.00000 || lon==0.00000){
              print('${lat}, ${lon}');
              const message = 'Please Select a location';
              const snackbar = const SnackBar(content: const Text(message));
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackbar);
            }
            else{
              final data=Loc(lat: lat, lon: lon);
              Navigator.pop(context, data);
            }
          }, child: Text("Select")

          )
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
}


