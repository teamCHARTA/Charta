import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'gmapservces/userloc.dart';

void main(){
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: ChartaLoc(),
    );
  }
}

class ChartaLoc extends StatelessWidget {
  const ChartaLoc({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map and Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctxt)=>GmapLoc(latlng: LatLng(40.7128,-74.0060),)
                ));
            }, child: Text('Click Here'))
          ],
        ),
      ),
    );
  }
}

