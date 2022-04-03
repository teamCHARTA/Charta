import 'package:charta/functions/database.dart';
import 'package:charta/qrscreens/Scanscraper.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../UIelements/uielement3.dart';
import '../../functions/colorfunction.dart';
import '../Detailpage/Scraperorderpaperdetails.dart';

class ScraperOrder extends StatefulWidget {
  static const String routeName = '/scrapeoreder';
  const ScraperOrder({Key? key}) : super(key: key);

  @override
  _ScraperOrderState createState() => _ScraperOrderState();
}

class _ScraperOrderState extends State<ScraperOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer3Widget(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Orders"),
      ),
      body: DoubleBackToCloseApp(
        child: Center(
          child: StreamBuilder<List<Product>>(
              stream: Database().ReadScraperorderpaper(),
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
                            child:   Text("Papers requested",
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScanScraper()));
          },
          child: const Icon(Icons.camera)),
    );
  }

  Widget buildPaper(Product paper) => Padding(
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
              radius: 35,
              child: Text(
                '${paper.usedpersent}%',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            title: Text('${paper.quantity} kg Requested',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color:
                        someColor().generateMaterialColor(Palette.secondary))),
            subtitle: Text(
              '${paper.usedpersent}% used  \nLocation: ${paper.Adress}\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}',
              style: TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scraperorderdetails(
                            url1: paper.url1,
                            url2: paper.url2,
                            productid: paper.productid,
                            quantity: paper.quantity,
                            uploadeddateandtime: paper.uploadeddateandtime,
                            uploaderid: paper.uploaderid,
                            usedpersent: paper.usedpersent,
                            lat: paper.lat,
                            lon: paper.lon,
                            adress: paper.Adress,
                          )));
            },
          ),
        ),
      );
}
