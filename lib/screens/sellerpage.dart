
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';
import 'Crudscreens/Addproduct.dart';
class Sellerpage extends StatefulWidget {
  const Sellerpage({Key? key}) : super(key: key);
  @override
  _SellerpageState createState() => _SellerpageState();
}

class _SellerpageState extends State<Sellerpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Column(
      children: [
        Center(child: Text("Sellerpage"),),
        TextButton(onPressed: (){
          final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
          provider.logout();
        }, child: Text("Logout")),
        const SizedBox(height: 10,),
        TextButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context)=>const Addproductpage()//calling with uniqueCode
          ));
        }, child: Text("Addproduct")),
      ],
    ),);
  }
}
