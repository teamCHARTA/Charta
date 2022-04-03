import 'package:charta/gmapservices/locationservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../../qrscreens/createqr.dart';

class UsserorderPaperdetails extends StatefulWidget {
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
  UsserorderPaperdetails({
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
  _UsserorderPaperdetailsState createState() => _UsserorderPaperdetailsState();
}

class _UsserorderPaperdetailsState extends State<UsserorderPaperdetails> {
  int enteredquantity = 0;
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                decoration: BoxDecoration(
                  color: someColor().generateMaterialColor(Palette.container),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CreateScreen(
                      uniqCode: widget.productid,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          "Seller has to scan this Before handovering Papers, because this QR has the Unique code"),
                    )
                  ],
                ),
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
                        "Used persentage: ${widget.usedpersent} %",
                        style: TextStyle(fontSize: 25),
                      ),
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
                        "Location : ${widget.adress}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          Getlocation().launchURL(widget.lat, widget.lon);
                        },
                        icon: FaIcon(FontAwesomeIcons.map),
                        label: Text("Get location on google map"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
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
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await Database().CancelUserorder(
                        widget.productid,
                        widget.sellerid,
                        widget.parentproductid,
                        widget.quantity);
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                      child: Text(
                    "Canel order",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  )),
                ),
              ),
            ]),
      ),
    );
  }
}
