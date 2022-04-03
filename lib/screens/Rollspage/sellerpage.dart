import 'package:charta/UIelements/uielement2,dart.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/qrscreens/scanqr.dart';
import 'package:charta/screens/Crudscreens/Addproduct.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../functions/colorfunction.dart';

class Sellerpage extends StatefulWidget {
  static const String routeName = '/sellerPage';
  const Sellerpage({Key? key}) : super(key: key);
  @override
  _SellerpageState createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavigationDrawer2Widget(),
      appBar: AppBar(
        title: const Text("Charta"),
        elevation: 0.0,
      ),
      body: DoubleBackToCloseApp(
        child: Center(
          child: StreamBuilder<List<Product>>(
              stream: Database().ReadSellerpaper(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  // final message = 'Enter the every data';
                  // final snackbar = SnackBar(content: Text(message));
                  // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  return Text('Something went Wrong');
                } else if (snapshot.hasData) {
                  final paper = snapshot.data!;
                  return ListView(
                    children: <Widget>[
                          Container(
                            height: 100,
                            color: someColor()
                                .generateMaterialColor(Palette.primary),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                            child: Text("Papers Added by you",
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animationSpeed: 100,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: true,
        curve: Curves.easeIn,
        overlayOpacity: 0,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: someColor().generateMaterialColor(Palette.primary),
        foregroundColor: someColor().generateMaterialColor(Palette.secondary),
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: someColor().generateMaterialColor(Palette.primary),
            labelWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: someColor().generateMaterialColor(Palette.primary)),
                margin: EdgeInsets.symmetric(horizontal: 2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add",
                    style: TextStyle(
                        fontSize: 20,
                        color: someColor()
                            .generateMaterialColor(Palette.secondary)),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              //Qrscan().scanQR(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Addproductpage()));

              //await Database().Scanreadpaper(id, context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.camera),
            backgroundColor: someColor().generateMaterialColor(Palette.primary),
            labelWidget: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: someColor().generateMaterialColor(Palette.primary)),
                margin: EdgeInsets.symmetric(horizontal: 2),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Scan",
                    style: TextStyle(
                        fontSize: 20,
                        color: someColor()
                            .generateMaterialColor(Palette.secondary)),
                  ),
                ),
              ),
            ),
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              //Qrscan().scanQR(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanScreen()));

              //await Database().Scanreadpaper(id, context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildPaper(Product paper) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: someColor().generateMaterialColor(Palette.container),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            tileColor: Color.fromRGBO(168, 255, 243, 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            leading: CircleAvatar(
              radius: 35,
              child: Text(
                '${paper.usedpersent}%',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            title: Text('${paper.usedpersent}% used',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary))),
            subtitle: Text(
              'id:${paper.productid}\n${paper.quantity} kg Added at \nLocation: ${paper.Adress}\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      );
}
