import 'package:charta/functions/colorfunction.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/gmapservices/locationservices.dart';
import 'package:charta/screens/Crudscreens/inhandpage.dart';
import 'package:charta/screens/Detailpage/Paperdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';

import '../../UIelements/uielements.dart';
import '../Crudscreens/scraprequestuserpage.dart';
import '../Crudscreens/userorders.dart';

class Userpage extends StatefulWidget {
  static const String routeName = '/userPage';
  const Userpage({Key? key}) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset:false,
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        elevation: 0.0,
        title: const Text("Home"),

      ),
      body: Center(
        child: StreamBuilder<List<Product>>(
            stream: Database().ReadUserpaper(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went Wrong');
              } else if (snapshot.hasData) {
                final paper = snapshot.data!;

                return ListView(
                  children: <Widget>[
                        Container(
                          height: 100,
                          color: someColor().generateMaterialColor(Palette.primary),
                        ), Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Join us to save WORLD",
                          style: TextStyle(fontSize:25)),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          leading: CircleAvatar(
            radius: 50,
            child: Text('${paper.usedpersent}%'),
          ),
          title: Text('${paper.usedpersent}% used'),
          subtitle: Text(
            '${paper.quantity} kg Available\nLocation: ${paper.Adress}\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}',
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Paperdetails(
                          Adress:paper.Adress,
                          url1: paper.url1,
                          url2: paper.url2,
                          productid: paper.productid,
                          quantity: paper.quantity,
                          uploadeddateandtime: paper.uploadeddateandtime,
                          uploaderid: paper.uploaderid,
                          usedpersent: paper.usedpersent,
                        )));
          },
        ),
      ),
    );
  }
}
