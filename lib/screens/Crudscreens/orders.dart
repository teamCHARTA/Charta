import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../UIelements/uielement2,dart.dart';
import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../../qrscreens/scanqr.dart';
import '../Detailpage/sellerorderpaperdetails.dart';

class Sellerorders extends StatefulWidget {
  static const String routeName = '/sellerorder';
  const Sellerorders({Key? key}) : super(key: key);

  @override
  _SellerordersState createState() => _SellerordersState();
}

class _SellerordersState extends State<Sellerorders> {
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
      drawer: NavigationDrawer2Widget(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Order"),
      ),
      body: DoubleBackToCloseApp(
        child: Center(
          child: StreamBuilder<List<SellerOrder>>(
              stream: Database().ReadSellerOrderpaper(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went Wrong');
                } else if (snapshot.hasData) {
                  final paper = snapshot.data!;
                  return ListView(
                    children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:  Text("Odres for you",
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

  Widget buildPaper(SellerOrder paper) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
            title: Text('${paper.quantity}kg needed',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary))),
            subtitle: Text(
              '${paper.usedpersent}% Used\nPaper location: ${paper.Adress}\n${Database().timeAgo(paper.Buyedtime.toDate())}',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  (MaterialPageRoute(
                      builder: (context) => Sellerorderpaperdetails(
                            url1: paper.url1,
                            url2: paper.url2,
                            productid: paper.productid,
                            quantity: paper.quantity,
                            uploadeddateandtime: paper.Buyedtime,
                            usedpersent: paper.usedpersent,
                            buyerid: paper.buyerid,
                            parentproductid: paper.parentproductid,
                            lat: paper.lat,
                            lon: paper.lon,
                            adress: paper.Adress,
                          ))));
            },
          ),
        ),
      );
}
