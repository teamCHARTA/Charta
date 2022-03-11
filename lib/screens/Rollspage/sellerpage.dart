import 'package:charta/functions/database.dart';
import 'package:charta/screens/Crudscreens/Addproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';


class Sellerpage extends StatefulWidget {
  const Sellerpage({Key? key}) : super(key: key);
  @override
  _SellerpageState createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
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
                          stream: Database().ReadSellerpaper(),
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
              



      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add,size:30,),
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>const Addproductpage())); },),
    );
    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       Center(child: Text("Sellerpage"),),
    //       TextButton(onPressed: (){
    //         final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
    //         provider.logout();
    //       }, child: Text("Logout")),
    //       const SizedBox(height: 10,),
    //       TextButton(onPressed: (){
    //         Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context)=>const Addproductpage()//calling with uniqueCode
    //         ));
    //       }, child: Text("Addproduct")),
    //       Text('Products you Added'),
    //       StreamBuilder<List<Product>>(
    //           stream: Database().Readpaper(),
    //           builder: (context, snapshot)
    //           {
    //
    //             if(snapshot.hasError){
    //               final message='Enter the every data';
    //               final snackbar=SnackBar(content: Text(message));
    //               ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //               return Text('Something went Wrong');
    //             }else if(snapshot.hasData){
    //               final paper = snapshot.data!;
    //               return ListView(
    //                 children: paper.map((buildPaper)).toList(),
    //
    //               );
    //             }else{
    //               return Center(child: CircularProgressIndicator());
    //             }
    //
    //           }),
    //     ],
    //   ),
    // ),);
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
        ),
  );

}
