import 'package:charta/functions/database.dart';
import 'package:charta/qrscreens/scanqr.dart';
import 'package:charta/screens/Crudscreens/Addproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';

import '../../functions/colorfunction.dart';
import '../Crudscreens/orders.dart';


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
      resizeToAvoidBottomInset:false,
      appBar: AppBar(title: const Text("Home"),actions: [
        TextButton(onPressed: (){
                final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
                provider.logout();
              }, child: Text("Logout",style: TextStyle(color: Colors.white),),),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Sellerorders()));
          },
          child: Text(
            "Myorders",
            style: TextStyle(color: Colors.white),
          ),
        ),


      ],),
      body: Center(
        child:
              StreamBuilder<List<Product>>(
                          stream: Database().ReadSellerpaper(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              // final message = 'Enter the every data';
                              // final snackbar = SnackBar(content: Text(message));
                              // ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              return Text('Something went Wrong');
                            } else if (snapshot.hasData) {
                              final paper = snapshot.data!;
                              return
                              ListView(
                              children:<Widget>[
                                Container(height: 100,color: Colors.red,),
                                const Text("Your Papers",style:TextStyle(fontSize: 40))
                              ]+paper.map((buildPaper)).toList(),
                              );

                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
              



      ),
      floatingActionButton: SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animationSpeed: 100,
      animatedIconTheme: IconThemeData(size: 22.0),
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: true,
      curve: Curves.easeIn,
      // overlayColor: Colors.black,
      overlayOpacity: 0,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.teal,
            label: 'Add paper',
            labelStyle: TextStyle(fontSize: 18.0),
          onTap: (){
            //Qrscan().scanQR(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Addproductpage()));

            //await Database().Scanreadpaper(id, context);
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.camera),
          backgroundColor: Colors.blue,
          label: 'Scanpaper',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: (){
            //Qrscan().scanQR(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ScanScreen()));

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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: someColor().generateMaterialColor(Palette.container),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        tileColor: Color.fromRGBO(168, 255, 243,0),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            leading: CircleAvatar(
              child: Text('${paper.usedpersent}%'),
            ),
            title: Text('${paper.usedpersent}% used'),
            subtitle: Text(
                '${paper.usedpersent}% used ${paper.quantity} kg Available\n${paper.Adress}\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}'),
          ),
    ),
  );

}
