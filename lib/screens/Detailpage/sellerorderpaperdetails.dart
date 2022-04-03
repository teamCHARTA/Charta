import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../../qrscreens/scanqr.dart';

class Sellerorderpaperdetails extends StatefulWidget {
  final value;
  final url1;
  final url2;
  final productid;
  final parentproductid;
  final uploadeddateandtime;
  final quantity;
  final usedpersent;
  final buyerid;
  final lat;
  final lon;
  final adress;
  const Sellerorderpaperdetails({
    this.lon,
    this.value,
    this.lat,
    this.adress,
    this.url2,
    this.url1,
    this.productid,
    this.uploadeddateandtime,
    this.quantity,
    this.usedpersent,
    this.buyerid,
    this.parentproductid,
  });

  @override
  _SellerorderpaperdetailsState createState() =>
      _SellerorderpaperdetailsState();
}

class _SellerorderpaperdetailsState extends State<Sellerorderpaperdetails> {
  var formkey = GlobalKey<FormState>();

  String code = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScanScreen()));
        },
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.quantity}kg wanted"),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                decoration: BoxDecoration(
                  color: someColor().generateMaterialColor(Palette.container),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Quantity: ${widget.quantity} kg Wanted",
                        style: TextStyle(fontSize: 25),
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
                        "Location : ${widget.adress}",
                        style: TextStyle(fontSize: 20),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
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
                    showAlertDialog(BuildContext context) {
                      // set up the buttons
                      Widget cancelButton = ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                      Widget continueButton = ElevatedButton(
                        child: Text("Handover"),
                        onPressed: () async {
                          if (formkey.currentState!.validate() &&
                              code == widget.productid) {
                            await Database().Handover(
                                widget.buyerid,
                                widget.parentproductid,
                                widget.productid,
                                widget.url1,
                                widget.url2,
                                widget.lat,
                                widget.lon,
                                widget.adress,
                                widget.quantity,
                                widget.usedpersent);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            print("Sucess");
                          } else {}
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        backgroundColor: someColor()
                            .generateMaterialColor(Palette.container),
                        title: Text(
                          "Enter the unique code",
                          style: TextStyle(
                              color: someColor()
                                  .generateMaterialColor(Palette.secondary)),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    initialValue: widget.value,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                            color: someColor()
                                                .generateMaterialColor(
                                                    Palette.secondary)),
                                        hintStyle: TextStyle(
                                            color: someColor()
                                                .generateMaterialColor(
                                                    Palette.secondary)),
                                        hintText: "Enter the unique code",
                                        labelText: "Code",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    validator: (text) {
                                      if (text!.isEmpty) {
                                        return "please enter the Code";
                                      }
                                      if (text != widget.productid) {
                                        return "Wrong code";
                                      } else {
                                        code = text;
                                        return null;
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }

                    showAlertDialog(context);
                  },
                  child: Center(
                      child: Text(
                    "Conform Handover",
                    style: TextStyle(
                        fontSize: 20,
                        color: someColor()
                            .generateMaterialColor(Palette.secondary)),
                  )),
                ),
              ),
            ]),
      ),
    );
  }
}
