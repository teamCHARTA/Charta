import 'package:charta/screens/scraperpage.dart';
import 'package:charta/screens/sellerpage.dart';
import 'package:charta/screens/userpage.dart';
import 'package:flutter/material.dart';
import 'package:charta/functions/database.dart';
import 'package:charta/functions/Signin.dart';
import 'package:charta/functions/roles.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override

  String uid=  FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!;

  late String rolestatus = Database().UserRole(uid);
  Widget build(BuildContext context) {

    if(rolestatus=="user"){
      return Userpage();
    }
    else if(rolestatus=="seller"){
      return Sellerpage();
    }
    else if(rolestatus=="scraper"){
      return Scrapperpage();
    }else{
      return Scaffold(
        body: Center(child: Column(
            children:[ SizedBox(height: 20),CircleAvatar(
              radius: 50,
              backgroundImage:NetworkImage(user.photoURL!) ,
            ),SizedBox(height: 8),
              Text(user.displayName!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
              SizedBox(height: 8),
              Text(user.email!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
              Text("no user data fount"),
              SizedBox(height: 20),
              TextButton(onPressed: (){
                final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
                provider.logout();
              }, child: Text("Logout"))
            ]
        ),),

      );;
    }
  }
}
