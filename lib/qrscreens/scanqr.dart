import 'package:charta/functions/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../functions/colorfunction.dart';

class ScanScreen extends StatefulWidget {
  String? qrstring;
  ScanScreen({Key? key, this.qrstring}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qRstring = 'Not Scanned';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Scan QR'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: someColor().generateMaterialColor(Palette.container),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width / 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        qRstring,
                        style: TextStyle(
                            color: someColor()
                                .generateMaterialColor(Palette.secondary),
                            fontSize: 30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            scanQR();
                          },
                          child: Text('Scan QR Code')),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Database().Scanreadpaper(qRstring, context);
                          },
                          child: Text('Search'))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: someColor().generateMaterialColor(Palette.container),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
              child: Text(
                  "Scan the QRcode of Buyer when they rech you.The Qrcode contains The unique Code. After Scaning tap search if that document exist you will be redirected to that page ",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: someColor().generateMaterialColor(Palette.secondary)),),
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'Cancel', true, ScanMode.QR)
          .then((value) => setState(() {
                qRstring = value;
                widget.qrstring = qRstring;
              }));
    } on PlatformException catch (e) {
      setState(() {
        qRstring = 'Try Again';
      });
    } catch (e) {
      setState(() {
        qRstring = 'Unable to Scan';
      });
    }
  }
}
