import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../functions/database.dart';
class ScanScraper extends StatefulWidget {
  String? qrstring;
   ScanScraper({this.qrstring});

  @override
  _ScanScraperState createState() => _ScanScraperState();
}
var qRstring ='Not Scanned';
class _ScanScraperState extends State<ScanScraper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(qRstring,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
              ),
            ),
            ElevatedButton(onPressed:(){scanQR();

            } , child: Text('Scan QR Code')),
            ElevatedButton(onPressed: (){Database().ScanScraperpaper(qRstring, context);}, child: Text('Redirect'))
          ],
        ),
      ),
    );
  }




  Future<void> scanQR() async{
    try {
      FlutterBarcodeScanner.scanBarcode(
          '#2A99CF', 'Cancel', true, ScanMode.QR
      ).then((value) => setState((){
        qRstring=value;
        widget.qrstring=qRstring;

      }));

    }
    on PlatformException catch(e){
      setState(() {
        qRstring='Try Again';
      });
    }

    catch (e) {
      setState(() {
        qRstring='Unable to Scan';
      });
    }


  }
}
