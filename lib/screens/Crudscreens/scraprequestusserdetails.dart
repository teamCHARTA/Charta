import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../functions/database.dart';
import '../../gmapservices/locationservices.dart';
import '../../qrscreens/createqr.dart';
class ScraprequestUsserdetails extends StatefulWidget {
  final url1;
  final url2;
  final productid;
  final parentproductid;
  final uploadeddateandtime;
  final quantity;
  final uploaderid;
  final usedpersent;
  final sellerid;
  final lat;
  final lon;
  final adress;

  const ScraprequestUsserdetails({ this.lon,
    this.lat,
    this.adress,
    this.url2,
    this.url1,
    this.productid,
    this.uploadeddateandtime,
    this.quantity,
    this.uploaderid,
    this.usedpersent,
    this.sellerid,
    this.parentproductid,}) ;

  @override
  _ScraprequestUsserdetailsState createState() => _ScraprequestUsserdetailsState();
}

class _ScraprequestUsserdetailsState extends State<ScraprequestUsserdetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('paper'),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CreateScreen(
                uniqCode: widget.productid,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.usedpersent} % Used papers.  ",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${widget.quantity} kg available. ",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Added on \n${widget.uploadeddateandtime.toDate()}",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 5,
                    child: Image(
                        fit: BoxFit.fitWidth, image: NetworkImage(widget.url1)),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //         fit: BoxFit.fitWidth,
                    //         image: NetworkImage(widget.url1)),
                    //     borderRadius: BorderRadius.circular(15)),
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width / 2) - 5,
                    child: Image(
                        fit: BoxFit.fitWidth, image: NetworkImage(widget.url2)),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),



            ]),
      ),
    );
  }
}
