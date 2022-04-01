import 'package:charta/screens/Detailpage/Inhanddetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../UIelements/uielements.dart';
import '../../functions/Signin.dart';
import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../Detailpage/usserorderpapaperdetails.dart';

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
        title: const Text("Inhand"),
      ),
      drawer: NavigationDrawerWidget(),
      body: Center(
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
                    Container(
                      height: 100,
                      color: someColor().generateMaterialColor(Palette.primary),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Papers in Your hand",
                          style: TextStyle(fontSize: 25)),
                    )
                  ] +
                      paper.map((buildPaper)).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        leading: CircleAvatar(
          child: Text('${paper.usedpersent}%'),
        ),
        title: Text('${paper.usedpersent}% used'),
        subtitle: Text(
            '${paper.usedpersent}% used ${paper.quantity} kg Available\n${Database().timeAgo(paper.Buyedtime.toDate())}'),
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
