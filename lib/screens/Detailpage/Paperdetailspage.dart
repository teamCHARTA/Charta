import 'package:charta/screens/Crudscreens/buyproductsnackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../functions/colorfunction.dart';
import '../../functions/database.dart';

class Paperdetails extends StatefulWidget {
  final Adress;
  final url1;
  final url2;
  final productid;
  final uploadeddateandtime;
  final quantity;
  final uploaderid;
  final usedpersent;
  Paperdetails({
    this.Adress,
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
  int enteredquantity = 0;
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('paper'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                          height: width / 2.1,
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
                          height: width / 2.1,
                        ),
                      ],
                    ),
                  ),
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
                        "Location : ${widget.Adress}",
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
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    showAlertDialog(BuildContext context) {
                      // set up the buttons
                      Widget cancelButton = TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Continue"),
                        onPressed: () async {
                          if (formkey.currentState!.validate() &&
                                                  enteredquantity != null) {
                                                Database().Buypaper(widget.productid,enteredquantity,widget.uploaderid);
                                              } else {
                                                print("error");
                                                const message = 'Enter the every data';
                                                const snackbar = const SnackBar(content: const Text(message));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackbar);
                                              }

                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Enter Quantity"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "Enter the quantity",
                                        labelText: "quantity",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0))),
                                    validator: (text) {
                                      if (int.parse(text!) == null ||
                                          int.parse(text) == 0) {
                                        return "please enter the Quantity";
                                      }
                                      if (int.parse(text) > widget.quantity) {
                                        return "Order out of stock";
                                      } else {
                                        enteredquantity = int.parse(text);
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
                  child: const Center(
                      child: Text(
                    "Buy this paper",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
            ]));
  }
}
