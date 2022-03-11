import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
class Paperdetails extends StatefulWidget {
  final url1;
  final url2;
  final productid;
  final uploadeddateandtime;
  final quantity;
  final uploaderid;
  final usedpersent;
   Paperdetails({
    this.url2,
    this.url1,
    this.productid,
    this.uploadeddateandtime,
    this.quantity,
    this.uploaderid,
    this.usedpersent,
  });


  @override
  _PaperdetailsState createState() => _PaperdetailsState();
}

class _PaperdetailsState extends State<Paperdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('paper'),),
      body: Column(

        children:[Expanded(
          child: Row(
           
            children: [
              Expanded(
                child: PageView(
                          children: [
                            Container(width:MediaQuery.of(context).size.width,
                                child: Image(fit: BoxFit.fitWidth,
                                    image: NetworkImage(widget.url1))),
                            Container(width:MediaQuery.of(context).size.width,
                              child: Image(fit:BoxFit.fitWidth,image: NetworkImage(widget.url2)),)
                          ],),
              ),
              Container(height: 150,
                color: Colors.red,),
            ],
          ),
        ),





      ]),

    );
  }
}
