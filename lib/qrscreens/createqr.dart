import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CreateScreen extends StatefulWidget {
  final String uniqCode;
  const CreateScreen({ Key? key,required this.uniqCode  }) : super(key: key);
  

  @override
  _CreateScreenState createState() => _CreateScreenState();
  
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BarcodeWidget(
              data: widget.uniqCode,
              height: 200,
              width: 250, 
            barcode: Barcode.qrCode()),
          ],
        )
        );

  }
}