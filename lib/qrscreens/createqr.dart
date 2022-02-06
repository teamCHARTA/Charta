import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CreateScreen extends StatefulWidget {
  final String uniqCode;
  const CreateScreen({ Key? key,required this.uniqCode  }) : super(key: key);
  

  @override
  _CreateScreenState createState() => _CreateScreenState();
  
}

class _CreateScreenState extends State<CreateScreen> {
  var qRstring='Be Happy:)';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BarcodeWidget(
              color: Colors.black,
              data: qRstring,
              height: 200,
              width: 250, 
            barcode: Barcode.qrCode()),
            Container(
              width: MediaQuery.of(context).size.width*.8,
              child: ElevatedButton(onPressed: (){
                setState(() {
                  qRstring=widget.uniqCode;
                });
              }, child: const Text('Generate'))
            )
          ],
        ),
      ),
    );
  }
}