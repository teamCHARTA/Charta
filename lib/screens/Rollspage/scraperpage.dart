import 'package:charta/screens/Detailpage/Scraperpaperdetails.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import '../../UIelements/uielement3.dart';
import '../../functions/colorfunction.dart';
import '../../functions/database.dart';

class Scrapperpage extends StatefulWidget {
  static const String routeName = '/scraperpage';
  const Scrapperpage({Key? key}) : super(key: key);

  @override
  _ScrapperpageState createState() => _ScrapperpageState();
}

class _ScrapperpageState extends State<Scrapperpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer3Widget(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Charta"),
      ),
      body: DoubleBackToCloseApp(
        child: Center(
          child: StreamBuilder<List<Product>>(
              stream: Database().ReadScraperpaper(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
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
                            padding: const EdgeInsets.all(8.0),
                            child:  Text("Ready to Scrap Papers",
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

  Widget buildPaper(Product paper) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
              '${paper.quantity}kg',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          title: Text('${paper.quantity}kg',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: someColor().generateMaterialColor(Palette.secondary))),
          subtitle: Text(
            '${paper.usedpersent}% used at \nLocation: ${paper.Adress}\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}',
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Scraperpaperdetails(
                          url1: paper.url1,
                          url2: paper.url2,
                          productid: paper.productid,
                          quantity: paper.quantity,
                          uploadeddateandtime: paper.uploadeddateandtime,
                          uploaderid: paper.uploaderid,
                          usedpersent: paper.usedpersent,
                          lon: paper.lon,
                          lat: paper.lat,
                          adress: paper.Adress,
                        )));
          },
        ),
      ),
    );
  }
}
