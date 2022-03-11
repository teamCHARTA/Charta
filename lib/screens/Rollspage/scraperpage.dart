import 'package:charta/functions/Signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charta/functions/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Scrapperpage extends StatefulWidget {
  const Scrapperpage({Key? key}) : super(key: key);

  @override
  _ScrapperpageState createState() => _ScrapperpageState();
}

class _ScrapperpageState extends State<Scrapperpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),actions: [TextButton(onPressed: (){
        final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
        provider.logout();
      }, child:Text("Logout",style: TextStyle(color: Colors.white),),),],),
      body:Column(
      children: [
        Center(child: Text("Scaperpage"),),
        TextButton(onPressed: (){
          final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
          provider.logout();
        }, child: Text("Logout"))
      ],
    ),);
  }
}
