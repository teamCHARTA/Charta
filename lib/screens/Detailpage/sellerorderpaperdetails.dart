import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../../functions/database.dart';
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
  const Sellerorderpaperdetails({this.lon,
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
    this.parentproductid,});

  @override
  _SellerorderpaperdetailsState createState() => _SellerorderpaperdetailsState();
}

class _SellerorderpaperdetailsState extends State<Sellerorderpaperdetails> {
  var formkey = GlobalKey<FormState>();

  String code="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('paper'),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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

              TextButton(
                onPressed: () async{
                  showAlertDialog(BuildContext context) {

                    // set up the buttons
                    Widget cancelButton = TextButton(
                      child: Text("Cancel"),
                      onPressed:  () {
                      Navigator.pop(context);
                      },
                    );
                    Widget continueButton = TextButton(
                      child: Text("Continue"),
                      onPressed:  () async{
                        if (formkey.currentState!.validate() &&
                            code == widget.productid ) {
                          await Database().Handover(widget.buyerid,widget.parentproductid,widget.productid,widget.url1,widget.url2,widget.lat,widget.lon,widget.adress,widget.quantity,widget.usedpersent);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          print("Sucess");
                        } else {
                        }
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Enter the unique code"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Form(
                            key: formkey,


                            child:Column(

                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  initialValue: widget.value,
                                  decoration: InputDecoration(
                                      hintText: "Enter the unique code",
                                      labelText: "Code",

                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8.0))),
                                  validator: (text) {
                                    if (text!.isEmpty) {
                                      return "please enter the Code";
                                    }
                                    if(text!=widget.productid){
                                      return "Wrong code";
                                    }
                                    else {
                                      code = text;
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ), )],
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
                      "Conform Handover",
                      style: TextStyle(fontSize: 20,color: Colors.red),
                    )),
              ),
            ]),
      ),
    );
  }
}
