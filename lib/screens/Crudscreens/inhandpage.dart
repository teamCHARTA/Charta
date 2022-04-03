import 'package:charta/screens/Detailpage/Inhanddetails.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


import '../../UIelements/uielements.dart';

import '../../functions/colorfunction.dart';
import '../../functions/database.dart';


class Inhand extends StatefulWidget {
  static const String routeName = '/inhand';
  const Inhand({Key? key}) : super(key: key);

  @override
  _InhandState createState() => _InhandState();
}

class _InhandState extends State<Inhand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("In Hand"),
      ),
      drawer: NavigationDrawerWidget(),
      body:
      DoubleBackToCloseApp(
        child:
        Center(
          child: StreamBuilder<List<userOrder>>(
              stream: Database().ReadInhandpaper(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final message = 'Enter the every data';
                  final snackbar = SnackBar(content: Text(message));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  return Text('Something went Wrong');
                } else if (snapshot.hasData) {
                  final paper = snapshot.data!;
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Papers in Your hand",
                            style: TextStyle(fontSize: 20,fontStyle:FontStyle.italic,color: someColor().generateMaterialColor(Palette.container))),
                      )
                    ] +
                        paper.map((buildPaper)).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
       ),

      ),
    );
  }




  Widget buildPaper(userOrder paper) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: someColor().generateMaterialColor(Palette.container),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        tileColor: Color.fromRGBO(168, 255, 243, 0),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: CircleAvatar(
          radius: 40,
          child: Text(
            '${paper.quantity}kg',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text('${paper.quantity}kg in Hand',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color:
                someColor().generateMaterialColor(Palette.secondary))),
        subtitle: Text(
          '${paper.usedpersent}% Used Paper\n${Database().timeAgo(paper.Buyedtime.toDate())}',
          style: TextStyle(fontSize: 15),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Inhanddetails(
                    url1: paper.url1,
                    url2: paper.url2,
                    productid: paper.productid,
                    quantity: paper.quantity,
                    uploadeddateandtime: paper.Buyedtime,
                    uploaderid: paper.sellerid,
                    usedpersent: paper.usedpersent,
                    sellerid:paper.sellerid,
                    parentproductid:paper.parentproductid,
                    lat: paper.lat,
                    lon: paper.lon,
                    adress: paper.Adress,

                  )));
        },
      ),
    ),
  );


}
