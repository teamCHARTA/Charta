import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../../gmapservices/locationSelectMap.dart';
import '../../gmapservices/locationservices.dart';
import '../../main.dart';
import '../../qrscreens/createqr.dart';
class Inhanddetails extends StatefulWidget {
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


  Inhanddetails({
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
    this.parentproductid,}) ;

  @override
  _InhanddetailsState createState() => _InhanddetailsState();
}
final data =Loc(lat: 0.00, lon: 0.00);
class _InhanddetailsState extends State<Inhanddetails> {
  String msg="";

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
                          height:MediaQuery.of(context).size.width / 2.1,
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


              Center(child: Enabledbutton(context, widget.usedpersent)),

            ]),
      ),
    );
  }

  Widget Enabledbutton(BuildContext context,int usedpersent){
    if(usedpersent==100){
      return Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text("Scraping Service Requested",style:TextStyle(fontSize: 20,color: Colors.grey),));

    }
    if(usedpersent<100){


      return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(onPressed: ()async{

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
                if(data.lon!=0.0 || data.lat!=0.0){
                  await Database().Scraprequestuser(widget.url1, widget.url2, widget.quantity, data.lat, data.lon,widget.productid);
                  setState(() {
                    widget.usedpersent=100;
                  });
                }
                else{
                  Database().Snakebar(NavigationService.navigatorKey.currentContext,"Enter correct location");
                }

              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Note"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 Text("Scrap request once made can't be changed.\nScraper will Contact you, for that please give your Information"),
                  SizedBox(height: 10,),

                  Column(

                    children: [
                      Column(
                        children: [
                          TextButton(onPressed:()async{
                            final location = await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=> LocMapSel()//calling with uniqueCode
                            )) as Loc;
                            setState(() {
                              data.lon=location.lon;
                              data.lat=location.lat;
                            });


                          }, child: Text("Select location from Map")),
                          Text("OR"),
                          SizedBox(width: 10,),
                          TextButton(onPressed:()async{
                            final Position position = await Getlocation().getGeoLocationPosition();
                            setState(() {
                              data.lon=position.longitude;
                              data.lat=position.latitude;
                            });
                          }, child: Text("Use divice location")),
                          SizedBox(width: 10,),
                           Text(msg,style: TextStyle(color: Colors.red),),
                        ],
                      ),

                    ],
                  ),],
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






        }, child: Text("Request Scrap",style: TextStyle(fontSize: 20,color: Colors.red),)),
      );
    }
    else{
      return Text("Something went Wrong");
    }



  }




}
