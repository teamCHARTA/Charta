import 'package:charta/gmapservices/gmaploc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Gmapmain extends StatefulWidget {
  const Gmapmain({Key? key}) : super(key: key);

  @override
  _GmapmainState createState() => _GmapmainState();
}

class _GmapmainState extends State<Gmapmain> {
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
