import 'package:charta/functions/database.dart';
import 'package:charta/screens/Detailpage/Paperdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';
class Userpage extends StatefulWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),actions: [TextButton(onPressed: (){
        final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
        provider.logout();
      }, child: Text("Logout",style: TextStyle(color: Colors.white),),),],),
      body: Center(
    child:
    StreamBuilder<List<Product>>(
        stream: Database().ReadUserpaper(),
    builder: (context, snapshot) {
    if (snapshot.hasError) {
    final message = 'Enter the every data';
    final snackbar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
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




    ),);
  }

  Widget buildPaper(Product paper) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
    child: ListTile(
      tileColor: Color.fromRGBO(168, 255, 243,0),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      leading: CircleAvatar(
        child: Text('${paper.usedpersent}%'),
      ),
      title: Text('${paper.usedpersent}% used'),
      subtitle: Text(
          '${paper.usedpersent}% used ${paper.quantity} kg Available\n${Database().timeAgo(paper.uploadeddateandtime.toDate())}'),
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> Paperdetails(
          url1:paper.url1,
          url2: paper.url2,
        productid: paper.productid,
        quantity: paper.quantity,
        uploadeddateandtime: paper.uploadeddateandtime,
        uploaderid: paper.uploaderid,
        usedpersent: paper.usedpersent,
      )));},
    ),
  );
}
