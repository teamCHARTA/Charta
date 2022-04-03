import 'package:charta/UIelements/uielements.dart';
import 'package:charta/functions/colorfunction.dart';
import 'package:charta/screens/Crudscreens/scraprequestusserdetails.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../functions/database.dart';

class ScraprequestAccpetuser extends StatefulWidget {
  static const String routeName = '/Scraprequestuser';
  const ScraprequestAccpetuser({Key? key}) : super(key: key);

  @override
  _ScraprequestAccpetuserState createState() => _ScraprequestAccpetuserState();
}

class _ScraprequestAccpetuserState extends State<ScraprequestAccpetuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Request"),
      ),
      body: DoubleBackToCloseApp(
        child: Center(
          child: StreamBuilder<List<Product>>(
              stream: Database().Readuserscrapacceptpaper(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went Wrong');
                } else if (snapshot.hasData) {
                  final paper = snapshot.data!;

                  return ListView(
                    children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Scrap request",
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
          title: Text('${paper.quantity}kg Requested',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:
                  someColor().generateMaterialColor(Palette.secondary))),
          subtitle: Text(
            '${paper.usedpersent}% Used Paper\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}',
            style: TextStyle(fontSize: 15),),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScraprequestUsserdetails(
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
}
