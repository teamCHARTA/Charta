import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../functions/colorfunction.dart';
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

  const ScraprequestUsserdetails({
    this.lon,
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
    this.parentproductid,
  });

  @override
  _ScraprequestUsserdetailsState createState() =>
      _ScraprequestUsserdetailsState();
}

class _ScraprequestUsserdetailsState extends State<ScraprequestUsserdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
              decoration: BoxDecoration(
                color: someColor().generateMaterialColor(Palette.container),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CreateScreen(
                      uniqCode: widget.productid,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          "Scraper has to scan this Before Accepting Papers, because this QR has the Unique code"),
                    )
                  ]),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: someColor().generateMaterialColor(Palette.container),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Quantity: ${widget.quantity} kg",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Used persentage: ${widget.usedpersent} %",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Added on : ${widget.uploadeddateandtime.toDate()}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              //padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: someColor().generateMaterialColor(Palette.container),
                borderRadius: BorderRadius.circular(10),
              ),

              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  widget.url1,
                                )),
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width * 0.52,
                        height: MediaQuery.of(context).size.width / 2.1,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(widget.url2)),
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width / 2.1,
                        height: MediaQuery.of(context).size.width / 2.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
