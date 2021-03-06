import 'package:charta/screens/Rollspage/adminpage.dart';
import 'package:charta/screens/Rollspage/scraperpage.dart';
import 'package:charta/screens/Rollspage/sellerpage.dart';
import 'package:charta/screens/Rollspage/userpage.dart';
import 'package:flutter/material.dart';
import 'package:charta/functions/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../UIelements/uielements.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({Key? key}) : super(key: key);

  @override
  _WelcomepageState createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!;

  final rolestatus = Database().UserRole();

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("user").doc(uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return switchrollpage(snapshot);
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
      // body: Center(child: Column(
      //     children:[ SizedBox(height: 20),CircleAvatar(
      //       radius: 50,
      //       backgroundImage:NetworkImage(user.photoURL!) ,
      //     ),SizedBox(height: 8),
      //       Text(user.displayName!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
      //       SizedBox(height: 8),
      //       Text(user.email!,style: TextStyle(color: Colors.lightGreen,fontSize: 16),),
      //       Text("no user data fount"),
      //       SizedBox(height: 20),
      //       TextButton(onPressed: (){
      //         final provider = Provider.of<GoogleSigninProvider>(context,listen: false);
      //         provider.logout();
      //       }, child: Text("Logout"))
      //     ]
      // ),),
    );
  }

  switchrollpage(AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.data!['role'] == 'admin') {
      return Adminpage();
    } else if (snapshot.data!['role'] == 'seller') {
      return Sellerpage();
    } else if (snapshot.data!['role'] == 'scraper') {
      return Scrapperpage();
    } else if (snapshot.data!['role'] == 'user') {
      return Userpage();
    } else {
      return Userpage();
    }
  }
}
