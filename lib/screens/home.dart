import 'package:charta/qrscreens/createqr.dart';
import 'package:charta/qrscreens/scanqr.dart';
import 'package:charta/screens/loginpage.dart';
import 'package:charta/screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charta/screens/LoggedinPage.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
              { return const Center(child: CircularProgressIndicator());
              }
          else if(snapshot.hasData){


            return const LoggedinPage();
          }
          else if (snapshot.hasError){
            return const Center(child: Text("Something went wrong"));
          }
            else{
              return const logtosignin();}



      } ,


      ),
    );
  }
}
