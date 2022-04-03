import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../functions/colorfunction.dart';
import '../../functions/database.dart';

class Scraperpaperdetails extends StatefulWidget {
  final url1;
  final url2;
  final productid;
  final parentproductid;
  final uploadeddateandtime;
  final quantity;
  final uploaderid;
  var usedpersent;
  final sellerid;
  final lat;
  final lon;
  final adress;

  Scraperpaperdetails({
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
  _ScraperpaperdetailsState createState() => _ScraperpaperdetailsState();
}

class _ScraperpaperdetailsState extends State<Scraperpaperdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: someColor()
                                .generateMaterialColor(Palette.secondary)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Used persentage: ${widget.usedpersent} %",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Location: ${widget.adress}",
                        style: TextStyle(fontSize: 18),
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
                  onPressed: () {
                    Database()
                        .Scraprequestscraper(
                            widget.url1,
                            widget.url2,
                            widget.quantity,
                            widget.lat,
                            widget.lon,
                            widget.productid,
                            widget.uploaderid)
                        .then((value) => Navigator.pop(context));
                  },
                  child: Center(
                      child: Text(
                    "Accept order",
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

  // Widget Enabledbutton(BuildContext context,int usedpersent){
  //
  //     return TextButton(onPressed: ()async{
  //
  //       showAlertDialog(BuildContext context) {
  //
  //         // set up the buttons
  //         Widget cancelButton = TextButton(
  //           child: Text("Cancel"),
  //           onPressed:  () {
  //             Navigator.pop(context);
  //           },
  //         );
  //         Widget continueButton = TextButton(
  //           child: Text("Continue"),
  //           onPressed:  (){
  //           },
  //         );
  //
  //         // set up the AlertDialog
  //         AlertDialog alert = AlertDialog(
  //           title: Text("Note"),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text("Scrap request once made can't be changed.\nScraper will Contact you, for that please give your Information"),
  //               SizedBox(height: 10,),
  //
  //               Column(
  //
  //                 children: [
  //
  //                 ],
  //               ),],
  //           ),
  //           actions: [
  //             cancelButton,
  //             continueButton,
  //           ],
  //         );
  //
  //         // show the dialog
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return alert;
  //           },
  //         );
  //       }
  //       showAlertDialog(context);
  //
  //
  //
  //
  //
  //
  //     }, child: Text("Request Scrap",style: TextStyle(fontSize: 20,color: Colors.red),));
  //
  //
  //
  //
  //
  // }

}
