import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../functions/Signin.dart';
import '../../functions/colorfunction.dart';
import '../../functions/database.dart';
import '../Detailpage/Paperdetailspage.dart';
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
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          TextButton(
            onPressed: () {
              final provider =
              Provider.of<GoogleSigninProvider>(context, listen: false);
              provider.logout();
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder<List<SellerOrder>>(
            stream: Database().ReadSellerOrderpaper(),
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
                      color: Colors.red,
                    ),
                    const Text("Your Papers",
                        style: TextStyle(fontSize: 40))
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

  Widget buildPaper(SellerOrder paper) => Padding(
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
              context,( MaterialPageRoute(builder: (context)=>Sellerorderpaperdetails(
            url1: paper.url1,
            url2: paper.url2,
            productid: paper.productid,
            quantity: paper.quantity,
            uploadeddateandtime: paper.Buyedtime,
            usedpersent: paper.usedpersent,
            buyerid:paper.buyerid,
            parentproductid:paper.parentproductid,
            lat: paper.lat,
            lon: paper.lon,
            adress: paper.Adress,
          ))));
        },
      ),
    ),
  );


}