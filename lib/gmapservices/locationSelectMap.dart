
import 'package:charta/functions/colorfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocMapSel extends StatefulWidget {
  const LocMapSel({Key? key}) : super(key: key);

  @override
  _LocMapSelState createState() => _LocMapSelState();
}

late GoogleMapController _controller;
double lat = 0.00000;
double lon = 0.00000;

class Loc {
  double lat = 0.00000;
  double lon = 0.00000;

  Loc({required this.lat, required this.lon});
}

List<Marker> mymarker = [];

class _LocMapSelState extends State<LocMapSel> {
  @override
  Widget build(BuildContext context) {
    final CameraPosition _initialCameraPosition =
        const CameraPosition(target: LatLng(8.5241, 76.9366), zoom: 11.5);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tap on your location"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  if (lat == 0.00000 || lon == 0.00000) {
                    print('${lat}, ${lon}');
                    const message = 'Please Select a location';
                    const snackbar = const SnackBar(content: const Text(message));
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  } else {
                    final data = Loc(lat: lat, lon: lon);
                    Navigator.pop(context, data);
                  }
                },
                child: Text(
                  "Select",
                  style: TextStyle(
                    fontSize: 20,
                      color:
                          someColor().generateMaterialColor(Palette.secondary)),
                )),
          )
        ],
      ),
      body: GoogleMap(
        markers: Set.from(mymarker),
        mapType: MapType.hybrid,
        onMapCreated: mapCreated,
        initialCameraPosition: _initialCameraPosition,

        //and/or any other parameters
        onTap: _handleTap,
      ),
    );
  }

  _handleTap(LatLng point) {
    setState(() {
      mymarker = [];
      mymarker.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'location',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));

      lat = point.latitude;
      lon = point.longitude;
    });
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}
